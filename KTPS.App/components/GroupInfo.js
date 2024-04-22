import React, { useState, useEffect } from 'react';
import { View, Text, RefreshControl, TouchableOpacity, StyleSheet, FlatList, Alert, Modal, TouchableWithoutFeedback, TextInput, Pressable, ActivityIndicator } from 'react-native';
import { useIsFocused } from "@react-navigation/native";
import Icon from 'react-native-vector-icons/FontAwesome';
import * as Constants from '../constants.js';
import AsyncStorage from "@react-native-async-storage/async-storage";

const GroupInfo = ({ navigation, route }) => {
    const isFocused = useIsFocused();
    const { groupId } = route.params;
    const [groupName, setGroupName] = useState('');
    const [userId, setUserId] = useState('');
    const [refreshing, setRefreshing] = useState(false);
    const [friendRefreshing, setFriendRefreshing] = useState(false);
    const [groupOwner, setGroupOwner] = useState('');
    const [members, setMembers] = useState([]);
    const [guests, setGuests] = useState([]);
    const [newGuestName, setNewGuestName] = useState('');
    const [isAddGuestOpen, setIsAddGuestOpen] = useState(false);
    const [isAddGuestDisabled, setIsAddGuestDisabled] = useState(false);
    const [isAddMemberOpen, setIsAddMemberOpen] = useState(false);
    const [friends, setFriends] = useState([]);

    const fetchFriends = async () => {
        const userId = await AsyncStorage.getItem("userId");
        try {
            const response = await fetch(Constants.BASE_URL + '/friends/list/' + userId);
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const responseData = await response.json();
            if (responseData.success && responseData.data) {
                setFriends(responseData.data);
            } else {
                throw new Error('Invalid response data');
            }
        } catch (error) {
            console.error('Error fetching friends:', error);
        }
    };

    const loadGroupInfo = async () => {
        try {
            const response = await fetch(Constants.BASE_URL + '/groups/' + groupId + '/info');

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            const responseData = await response.json();
            if (responseData.success && responseData.data) {
                setGroupName(responseData.data.name);
                setGroupOwner(responseData.data.ownerUserID);
            } else {
                throw new Error('Invalid response data');
            }
        } catch (error) {
            console.error('Error loading group info:', error);
            Alert.alert('Error', 'An error occurred while loading group. Please try again later.');
        }
    };

    const loadGroupMember = async () => {
        try {
            const response = await fetch(Constants.BASE_URL + '/groups/' + groupId + '/members');

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            const responseData = await response.json();
            if (responseData.success && responseData.data) {
                setMembers(responseData.data.members);
                setGuests(responseData.data.guests);
            } else {
                throw new Error('Invalid response data');
            }
        } catch (error) {
            console.error('Error loading group members:', error);
            Alert.alert('Error', 'An error occurred while loading group members. Please try again later.');
        }
    };

    const fetchUserId = async () => {
        const userIdFetch = await AsyncStorage.getItem("userId");
        setUserId(userIdFetch);
    }

    useEffect(() => {
        loadGroupInfo();
        loadGroupMember();
        fetchUserId();
        fetchFriends();
    }, []);

    useEffect(() => {
        if (isFocused) {
            loadGroupInfo();
            loadGroupMember();
            fetchFriends();
        }
    }, [isFocused]);

    const onFriendRefresh = async () => {
        setFriendRefreshing(true);
        await loadGroupMember();
        setFriendRefreshing(false);
    };

    const onRefresh = async () => {
        setRefreshing(true);
        onFriendRefresh();
        await loadGroupMember();
        setRefreshing(false);
    };

    const renderItem = ({ item, index }) => {
        let sectionTitle = '';
        let data = [];
        let itemType = '';
        let addButtonTitle = '';

        if (index === 0) {
            sectionTitle = 'Members';
            data = members;
            itemType = 'member';
            addButtonTitle = 'Add Member';
        } else {
            sectionTitle = 'Guests';
            data = guests;
            itemType = 'guest';
            addButtonTitle = 'Add Guest';
        }

        return (
            <View style={styles.section}>
                <Text style={styles.sectionTitle}>{sectionTitle}</Text>
                {data.map(memberOrGuest => (
                    <View key={memberOrGuest.id} style={styles.memberItem}>
                        <Text style={styles.memberText}>{memberOrGuest.username || memberOrGuest.userID || memberOrGuest.name}</Text>
                        {userId == groupOwner && (
                            <TouchableOpacity onPress={() => confirmDelete(memberOrGuest.userID ? memberOrGuest.userID : memberOrGuest.id, itemType)}>
                                <Icon name="trash" size={20} color="red" style={styles.icon} />
                            </TouchableOpacity>
                        )}
                    </View>
                ))}
                {userId == groupOwner && (
                    <TouchableOpacity style={styles.addButton} onPress={() => handleAdd(itemType)}>
                        <Text style={styles.addButtonText}>{addButtonTitle}</Text>
                    </TouchableOpacity>
                )}
            </View>
        );
    };

    const handleAdd = (itemType) => {
        if (itemType == 'guest') {
            setIsAddGuestOpen(true);
        }
        if (itemType == 'member') {
            if(friends == null){
                Alert.alert('Error', 'No friends found!');
                return;
            }
            setIsAddMemberOpen(true);
        }
    };

    const confirmDelete = async (id, itemType) => {
        Alert.alert(
            'Confirm Removal',
            `Are you sure you want to remove ${itemType}?`,
            [
                { text: 'Cancel', style: 'cancel' },
                { text: 'Remove', onPress: () => handleDelete(id, itemType) }
            ]
        );
    };

    const handleDelete = async (id, itemType) => {
        const userId = await AsyncStorage.getItem("userId");
        try {
            const response = await fetch(Constants.BASE_URL + '/groups/remove_members', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    RequestUserID: userId,
                    GroupID: groupId,
                    UserToRemoveID: itemType == "member" ? id : null,
                    GuestToRemoveID: itemType == "guest" ? id : null,
                }),
            });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const responseData = await response.json();
            if (responseData.success) {
                onRefresh();
            } else {
                throw new Error('Failed to delete member/guest');
            }
        } catch (error) {
            console.error('Error deleting member/guest:', error);
            Alert.alert('Error', 'An error occurred while deleting member/guest. Please try again later.');
        }
    };

    const handleAddGuest = async () => {
        if (newGuestName.trim() === '') {
            Alert.alert('Error', 'Guest name cannot be empty.');
            return;
        }

        setIsAddGuestDisabled(true);

        try {
            const response = await fetch(Constants.BASE_URL + '/groups/add_guest', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    GroupID: groupId,
                    Name: newGuestName
                }),
            });

            const data = await response.json();
            if (data.success == true) {
                onRefresh();
            } else {
                Alert.alert('Error', data.message);
            }
        } catch (error) {
            Alert.alert('Error', 'An error occurred. Please try again later.');
        } finally {
            setIsAddGuestOpen(false);
            setIsAddGuestDisabled(false);
            setNewGuestName('');
        }
    }

    const handleAddFriend = async (friendId) => {
        try {
            const userId = await AsyncStorage.getItem("userId");
            const requestData = {
                SenderID: parseInt(userId),
                ReceiverID: friendId,
                GroupId: groupId,
                Type: "Group"
            };
    
            const response = await fetch(Constants.BASE_URL + '/notification/create', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestData),
            });
    
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
    
            Alert.alert('Success', 'Group invitation sent successfully.');
        } catch (error) {
            console.error('Error sending group invitation:', error);
            Alert.alert('Error', 'An error occurred while sending group invitation. Please try again later.');
        }
    };

    const renderFriendItem = ({ item }) => {
        const isAlreadyMember = [...members].some(member => member.userID === item.id);
        if (!isAlreadyMember) {
            return (
                <View style={styles.friendItem}>
                    <Text style={styles.username}>{item.username}</Text>
                    <TouchableOpacity onPress={() => handleAddFriend(item.id)}>
                        <Icon name="plus" size={20} color="green" />
                    </TouchableOpacity>
                </View>
            );
        } else {
            return null;
        }
    };

    return (
        <View style={styles.container}>
            <View style={styles.header}>
                <TouchableOpacity style={styles.backButton} onPress={() => navigation.goBack()}>
                    <Icon name="arrow-left" size={20} color="#fff" />
                </TouchableOpacity>
                <Text style={styles.groupName}>{groupName}</Text>
            </View>
            <FlatList
                data={[null, null]}
                renderItem={renderItem}
                keyExtractor={(item, index) => index.toString()}
                refreshControl={
                    <RefreshControl
                        refreshing={refreshing}
                        onRefresh={onRefresh}
                    />
                }
            />
            <Modal
                transparent={true}
                animationType='fade'
                visible={isAddGuestOpen}
                onRequestClose={() => { setIsAddGuestOpen(false); setNewGuestName(''); }}
            >
                <TouchableWithoutFeedback onPress={() => { setIsAddGuestOpen(false); setNewGuestName(''); }}>
                    <View style={styles.modalContainer}>
                        <TouchableWithoutFeedback>
                            <View style={styles.groupModalContent}>
                                <View style={styles.inputView}>
                                    <TextInput
                                        style={styles.groupInput}
                                        placeholder='Enter guest name'
                                        placeholderTextColor='grey'
                                        value={newGuestName}
                                        onChangeText={setNewGuestName}
                                        autoCorrect={false}
                                        autoCapitalize='none'
                                    />
                                    <Pressable
                                        style={[styles.button, isAddGuestDisabled && styles.disabledButton]}
                                        onPress={() => handleAddGuest()}
                                        disabled={isAddGuestDisabled}
                                    >
                                        {isAddGuestDisabled ? (
                                            <ActivityIndicator size="small" color="#ffffff" />
                                        ) : (
                                            <Text style={styles.buttonText}>Add</Text>
                                        )}
                                    </Pressable>
                                </View>
                            </View>
                        </TouchableWithoutFeedback>
                    </View>
                </TouchableWithoutFeedback>
            </Modal>
            <Modal
                transparent={true}
                animationType='fade'
                visible={isAddMemberOpen}
                onRequestClose={() => { setIsAddMemberOpen(false); }}
            >
                <TouchableWithoutFeedback onPress={() => { setIsAddMemberOpen(false); }}>
                    <View style={styles.modalContainer}>
                        <TouchableWithoutFeedback>
                            <View style={styles.groupModalContent}>
                                <View style={styles.inputView}>
                                <FlatList
                                    data={friends}
                                    renderItem={renderFriendItem}
                                    keyExtractor={(item) => item.id.toString()}
                                    refreshControl={
                                        <RefreshControl
                                            refreshing={friendRefreshing}
                                            onRefresh={onFriendRefresh}
                                        />
                                    }
                                />
                                </View>
                            </View>
                        </TouchableWithoutFeedback>
                    </View>
                </TouchableWithoutFeedback>
            </Modal>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
    },
    header: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingHorizontal: 20,
        paddingVertical: 15,
        borderBottomWidth: 1,
        borderBottomColor: '#ccc',
    },
    backButton: {
        backgroundColor: 'red',
        paddingVertical: 10,
        paddingHorizontal: 15,
        borderRadius: 25,
    },
    addButton: {
        marginTop: 10,
        backgroundColor: '#007AFF',
        paddingVertical: 12,
        paddingHorizontal: 20,
        borderRadius: 8,
        alignItems: 'center',
    },
    addButtonText: {
        color: '#fff',
        fontSize: 16,
        fontWeight: 'bold',
    },
    groupName: {
        fontSize: 18,
        fontWeight: 'bold',
    },
    section: {
        marginBottom: 20,
        paddingHorizontal: 20,
    },
    sectionTitle: {
        fontSize: 16,
        fontWeight: 'bold',
        marginBottom: 10,
        color: '#333',
    },
    memberItem: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingVertical: 10,
        paddingHorizontal: 20,
        backgroundColor: '#f9f9f9',
        borderRadius: 8,
    },
    memberText: {
        fontSize: 16,
        color: '#333',
    },
    icon: {
        marginLeft: 10,
    },
    modalContainer: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: 'rgba(0, 0, 0, 0.5)',
    },
    groupModalContent: {
        backgroundColor: 'white',
        padding: 10,
        borderRadius: 10,
        alignItems: 'center',
        justifyContent: 'center',
        width: '80%'
    },
    inputView: {
        gap: 20,
        width: '100%',
        paddingHorizontal: 40,
        marginBottom: 25,
    },
    groupInput: {
        height: 40,
        width: '100%',
        paddingHorizontal: 20,
        borderColor: 'red',
        borderWidth: 1,
        borderRadius: 10,
        marginBottom: 5,
        marginTop: 20
    },
    button: {
        backgroundColor: 'red',
        height: 45,
        borderColor: 'gray',
        borderWidth: 1,
        borderRadius: 25,
        alignItems: 'center',
        justifyContent: 'center',
    },
    buttonText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
    },
    friendItem: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        borderBottomWidth: 1,
        borderBottomColor: '#ccc',
        paddingVertical: 10,
    },
    username: {
        fontSize: 16,
    },
});


export default GroupInfo;
