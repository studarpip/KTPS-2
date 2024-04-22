import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, FlatList, RefreshControl, StyleSheet, Alert, Modal, TouchableWithoutFeedback, TextInput, Pressable, ActivityIndicator } from 'react-native';
import AsyncStorage from "@react-native-async-storage/async-storage";
import * as Constants from '../constants.js';
import Icon from 'react-native-vector-icons/FontAwesome';
import { useIsFocused } from "@react-navigation/native";


const GroupList = ({ navigation }) => {
    const [groups, setGroups] = useState([]);
    const [refreshing, setRefreshing] = useState(false);
    const isFocused = useIsFocused();
    const [userId, setUserId] = useState('');
    const [isGroupCreateModalOpen, setIsGroupCreateModalOpen] = useState(false);
    const [isNewGroupSubmitDisabled, setIsNewGroupSubmitDisabled] = useState(false);
    const [groupName, setGroupName] = useState('');
    const [isGroupEditModalOpen, setIsGroupEditModalOpen] = useState(false);
    const [isEditGroupSubmitDisabled, setIsEditGroupSubmitDisabled] = useState(false);
    const [newGroupName, setNewGroupName] = useState('');
    const [editGroupId, setEditGroupId] = useState('');


    const fetchGroups = async () => {
        try {
            const userIdFetch = await AsyncStorage.getItem("userId");
            const response = await fetch(Constants.BASE_URL + '/groups/users/' + userIdFetch + '/list');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const responseData = await response.json();
            if (responseData.success && responseData.data) {
                setGroups(responseData.data);
            } else {
                throw new Error('Invalid response data');
            }
        } catch (error) {
            console.error('Error fetching groups:', error);
        }
    };

    const fetchUserId = async () => {
        const userIdFetch = await AsyncStorage.getItem("userId");
        setUserId(userIdFetch);
    }

    const onRefresh = async () => {
        setRefreshing(true);
        await fetchGroups();
        setRefreshing(false);
    };

    const deleteGroup = async (groupId, groupName) => {
        Alert.alert(
            'Confirm Deletion',
            `Are you sure you want to delete ${groupName}?`,
            [
                { text: 'Cancel', style: 'cancel' },
                { text: 'Delete', onPress: () => deleteGroupRequest(groupId) }
            ]
        );
    };

    const leaveGroup = async (groupId, groupName) => {
        Alert.alert(
            'Confirm leaving',
            `Are you sure you want to leave ${groupName}?`,
            [
                { text: 'Cancel', style: 'cancel' },
                { text: 'Leave', onPress: () => leaveGroupRequest(groupId) }
            ]
        );
    };

    const editGroup = async (groupId, groupName) => {
        setGroupName(groupName);
        setNewGroupName(groupName);
        setEditGroupId(groupId);
        setIsGroupEditModalOpen(true);
    };

    const deleteGroupRequest = async (groupId) => {
        try {
            const response = await fetch(Constants.BASE_URL + '/groups/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    ID: groupId,
                    UserID: userId
                }),
            });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const responseData = await response.json();
            if (responseData.success) {
                setGroups(prevGroups => prevGroups.filter(group => group.id !== groupId));
            } else {
                throw new Error('Failed to delete group');
            }
        } catch (error) {
            console.error('Error deleting group:', error);
            Alert.alert('Error', 'An error occurred while deleting the group. Please try again later.');
        }
    };

    const leaveGroupRequest = async (groupId) => {
        try {
            const response = await fetch(Constants.BASE_URL + '/groups/leave', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    GroupID: groupId,
                    UserID: userId
                }),
            });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const responseData = await response.json();
            if (responseData.success) {
                setGroups(prevGroups => prevGroups.filter(group => group.id !== groupId));
            } else {
                throw new Error('Failed to leaeve group');
            }
        } catch (error) {
            console.error('Error leaving group:', error);
            Alert.alert('Error', 'An error occurred while leaving the group. Please try again later.');
        }
    };

    useEffect(() => {
        fetchUserId();
        fetchGroups();
    }, []);

    useEffect(() => {
        if (isFocused)
            fetchGroups();
    }, [isFocused]);

    const handleNewGroupButton = () => {
        setIsGroupCreateModalOpen(true);
    };

    const renderGroupItem = ({ item }) => {
        const navigateToGroupInfo = (groupId) => {
            navigation.navigate('GroupInfo', { groupId: groupId });
        };
    
        return (
            <TouchableOpacity onPress={() => navigateToGroupInfo(item.id)}>
                <View style={styles.groupItem}>
                    <Text style={styles.name}>{item.name}</Text>
                    <View style={styles.actionContainer}>
                        {item.ownerUserID == userId && (
                            <TouchableOpacity onPress={() => editGroup(item.id, item.name)}>
                                <Icon name="pencil" size={20} color="blue" style={styles.icon} />
                            </TouchableOpacity>
                        )}
                        {item.ownerUserID == userId && (
                            <TouchableOpacity onPress={() => deleteGroup(item.id, item.name)}>
                                <Icon name="trash" size={20} color="red" style={styles.icon} />
                            </TouchableOpacity>
                        )}
                        {item.ownerUserID != userId && (
                            <TouchableOpacity onPress={() => leaveGroup(item.id, item.name)}>
                                <Icon name="sign-out" size={20} color="red" style={styles.icon} />
                            </TouchableOpacity>
                        )}
                    </View>
                </View>
            </TouchableOpacity>
        );
    };

    const handleGroupCreate = async () => {
        if (groupName.trim() === '') {
            Alert.alert('Error', 'Group name cannot be empty.');
            return;
        }

        setIsNewGroupSubmitDisabled(true);

        try {
            const userIdFetch = await AsyncStorage.getItem("userId");
            const response = await fetch(Constants.BASE_URL + '/groups/new', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    Name: groupName,
                    UserID: userIdFetch
                }),
            });

            const data = await response.json();
            if (data.success == true) {
                fetchGroups();
            } else {
                Alert.alert('Error', data.message);
            }
        } catch (error) {
            Alert.alert('Error', 'An error occurred. Please try again later.');
        } finally {
            setIsGroupCreateModalOpen(false);
            setIsNewGroupSubmitDisabled(false);
            setGroupName('');
        }
    }

    const handleGroupEdit = async () => {
        if (newGroupName.trim() === '') {
            Alert.alert('Error', 'Group name cannot be empty.');
            return;
        }

        if (newGroupName === groupName) {
            Alert.alert('Error', 'No changes.');
            return;
        }

        setIsEditGroupSubmitDisabled(true);

        try {
            const userIdFetch = await AsyncStorage.getItem("userId");
            const response = await fetch(Constants.BASE_URL + '/groups/edit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    ID: editGroupId,
                    Name: newGroupName,
                    UserID: userIdFetch
                }),
            });

            const data = await response.json();
            if (data.success == true) {
                fetchGroups();
            } else {
                Alert.alert('Error', data.message);
            }
        } catch (error) {
            Alert.alert('Error', 'An error occurred. Please try again later.');
        } finally {
            setIsGroupEditModalOpen(false);
            setIsEditGroupSubmitDisabled(false);
            setGroupName('');
            setNewGroupName('');
            setEditGroupId('');
        }
    }

    return (
        <View style={styles.container}>
            <View style={styles.buttonContainer}>
                <TouchableOpacity style={styles.createGroupButton} onPress={handleNewGroupButton}>
                    <Text style={styles.createGroupButtonText}>Create new group</Text>
                </TouchableOpacity>
            </View>
            <FlatList
                data={groups}
                renderItem={renderGroupItem}
                keyExtractor={(item) => item.id.toString()}
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
                visible={isGroupCreateModalOpen}
                onRequestClose={() => { setIsGroupCreateModalOpen(false); setGroupName(''); }}
            >
                <TouchableWithoutFeedback onPress={() => { setIsGroupCreateModalOpen(false); setGroupName(''); }}>
                    <View style={styles.modalContainer}>
                        <TouchableWithoutFeedback>
                            <View style={styles.groupModalContent}>
                                <View style={styles.inputView}>
                                    <TextInput
                                        style={styles.groupInput}
                                        placeholder='Enter group name'
                                        placeholderTextColor='grey'
                                        value={groupName}
                                        onChangeText={setGroupName}
                                        autoCorrect={false}
                                        autoCapitalize='none'
                                    />
                                    <Pressable
                                        style={[styles.button, isNewGroupSubmitDisabled && styles.disabledButton]}
                                        onPress={() => handleGroupCreate()}
                                        disabled={isNewGroupSubmitDisabled}
                                    >
                                        {isNewGroupSubmitDisabled ? (
                                            <ActivityIndicator size="small" color="#ffffff" />
                                        ) : (
                                            <Text style={styles.buttonText}>Create</Text>
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
                visible={isGroupEditModalOpen}
                onRequestClose={() => { setIsGroupEditModalOpen(false); setNewGroupName(''); setEditGroupId(''); setGroupName(''); }}
            >
                <TouchableWithoutFeedback onPress={() => { setIsGroupEditModalOpen(false); setNewGroupName(''); setEditGroupId(''); setGroupName(''); }}>
                    <View style={styles.modalContainer}>
                        <TouchableWithoutFeedback>
                            <View style={styles.groupModalContent}>
                                <View style={styles.inputView}>
                                    <TextInput
                                        style={styles.groupInput}
                                        placeholder={newGroupName}
                                        placeholderTextColor='grey'
                                        value={newGroupName}
                                        onChangeText={setNewGroupName}
                                        autoCorrect={false}
                                        autoCapitalize='none'
                                    />
                                    <Pressable
                                        style={[styles.button, isEditGroupSubmitDisabled && styles.disabledButton]}
                                        onPress={() => handleGroupEdit()}
                                        disabled={isEditGroupSubmitDisabled}
                                    >
                                        {isEditGroupSubmitDisabled ? (
                                            <ActivityIndicator size="small" color="#ffffff" />
                                        ) : (
                                            <Text style={styles.buttonText}>Edit</Text>
                                        )}
                                    </Pressable>
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
        padding: 20,
        backgroundColor: '#fff',
    },
    buttonContainer: {
        justifyContent: 'center',
        alignItems: 'center',
    },
    groupItem: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        borderBottomWidth: 1,
        borderBottomColor: '#ccc',
        paddingVertical: 10,
    },
    name: {
        fontSize: 16,
    },
    createGroupButton: {
        backgroundColor: 'red',
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 25,
    },
    createGroupButtonText: {
        color: '#fff',
        fontSize: 16,
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
    actionContainer: {
        flexDirection: 'row',
        justifyContent: 'center'
    },
    icon: {
        marginLeft: 10,
    },
});

export default GroupList;
