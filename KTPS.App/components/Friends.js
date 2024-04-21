import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, FlatList, RefreshControl, StyleSheet, Alert } from 'react-native';
import AsyncStorage from "@react-native-async-storage/async-storage";
import * as Constants from '../constants.js';
import Icon from 'react-native-vector-icons/FontAwesome';
import { useIsFocused } from "@react-navigation/native";


const FriendsForm = ({ navigation }) => {
    const [friends, setFriends] = useState([]);
    const [refreshing, setRefreshing] = useState(false);
    const isFocused = useIsFocused();

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

    const onRefresh = async () => {
        setRefreshing(true);
        await fetchFriends();
        setRefreshing(false);
    };

    const removeFriend = async (friendId, friendName) => {
        Alert.alert(
            'Confirm Deletion',
            `Are you sure you want to delete ${friendName}?`,
            [
                { text: 'Cancel', style: 'cancel' },
                { text: 'Delete', onPress: () => deleteFriendRequest(friendId) }
            ]
        );
    };

    const deleteFriendRequest = async (friendId,) => {
        const userId = await AsyncStorage.getItem("userId");
        try {
            const response = await fetch(Constants.BASE_URL + '/friends/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    UserID: userId,
                    FriendID: friendId
                }),
            });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const responseData = await response.json();
            if (responseData.success) {
                setFriends(prevFriends => prevFriends.filter(friend => friend.id !== friendId));
            } else {
                throw new Error('Failed to delete friend');
            }
        } catch (error) {
            console.error('Error deleting friend:', error);
            Alert.alert('Error', 'An error occurred while deleting the friend. Please try again later.');
        }
    };

    useEffect(() => {
        fetchFriends();
    }, []);

    useEffect(() => {
        if(isFocused)
            fetchFriends();
    }, [isFocused]);

    const handleFindFriends = () => {
        navigation.navigate('FindFriends');
    };

    const renderFriendItem = ({ item }) => (
        <View style={styles.friendItem}>
            <Text style={styles.username}>{item.username}</Text>
            <TouchableOpacity onPress={() => removeFriend(item.id, item.username)}>
                <Icon name="trash" size={20} color="red" />
            </TouchableOpacity>
        </View>
    );

    return (
        <View style={styles.container}>
            <View style={styles.buttonContainer}>
                <TouchableOpacity style={styles.findFriendsButton} onPress={handleFindFriends}>
                    <Text style={styles.findFriendsButtonText}>Find Friends</Text>
                </TouchableOpacity>
            </View>
            <FlatList
                data={friends}
                renderItem={renderFriendItem}
                keyExtractor={(item) => item.id.toString()}
                refreshControl={
                    <RefreshControl
                        refreshing={refreshing}
                        onRefresh={onRefresh}
                    />
                }
            />
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
    findFriendsButton: {
        backgroundColor: 'red',
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 25,
      },
    findFriendsButtonText: {
        color: '#fff',
        fontSize: 16,
    },
});

export default FriendsForm;
