import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, FlatList, Alert } from 'react-native';
import AsyncStorage from "@react-native-async-storage/async-storage";
import * as Constants from '../constants.js';
import Icon from 'react-native-vector-icons/FontAwesome';

const FindFriends = ({ navigation }) => {
    const [searchText, setSearchText] = useState('');
    const [searchResults, setSearchResults] = useState([]);

    const handleSearch = async () => {
        try {
            const userId = await AsyncStorage.getItem("userId");
            const requestData = {
                Input: searchText,
                UserID: userId
            };

            const response = await fetch(Constants.BASE_URL + '/friends/find', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestData),
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            const responseData = await response.json();
            if (responseData.success && responseData.data) {
                setSearchResults(responseData.data);
            } else {
                throw new Error('Invalid response data');
            }
        } catch (error) {
            console.error('Error searching for friends:', error);
            Alert.alert('Error', 'An error occurred while searching for friends. Please try again later.');
        }
    };

    const addFriend = async (friendId, friendName) => {
        Alert.alert(
            'Confirm Invitation',
            `Are you sure you want to invite ${friendName} to be a friend?`,
            [
                { text: 'Cancel', style: 'cancel' },
                { text: 'Invite', onPress: () => handleAddFriend(friendId) }
            ]
        );
    };

    const handleAddFriend = async (friendId) => {
        try {
            const userId = await AsyncStorage.getItem("userId");
            const requestData = {
                SenderID: parseInt(userId),
                ReceiverID: friendId,
                Type: "Friend"
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
    
            Alert.alert('Success', 'Friend invitation sent successfully.');
        } catch (error) {
            console.error('Error sending friend invitation:', error);
            Alert.alert('Error', 'An error occurred while sending friend invitation. Please try again later.');
        }
    };

    const renderFriendItem = ({ item }) => (
        <View style={styles.friendItem}>
            <Text style={styles.username}>{item.username}</Text>
            <TouchableOpacity onPress={() => addFriend(item.id, item.username)}>
                <Icon name="plus" size={20} color="green" />
            </TouchableOpacity>
        </View>
    );

    return (
        <View style={styles.container}>
            <View style={styles.header}>
                <TouchableOpacity style={styles.backButton} onPress={() => navigation.goBack()}>
                    <Icon name="arrow-left" size={20} color="#fff" />
                </TouchableOpacity>
                <View style={styles.searchContainer}>
                    <TextInput
                        style={styles.input}
                        placeholder="Enter username"
                        value={searchText}
                        onChangeText={setSearchText}
                    />
                    <TouchableOpacity style={styles.searchButton} onPress={handleSearch}>
                        <Icon name="search" size={20} color="#fff" />
                    </TouchableOpacity>
                </View>
            </View>
            <FlatList
                data={searchResults}
                renderItem={renderFriendItem}
                keyExtractor={(item) => item.id.toString()}
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
    header: {
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 10,
    },
    backButton: {
        backgroundColor: 'red',
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 25,
        marginRight: 10,
    },
    searchContainer: {
        flex: 1,
        flexDirection: 'row',
        alignItems: 'center',
    },
    input: {
        flex: 1,
        height: 45,
        paddingHorizontal: 20,
        borderColor: 'red',
        borderWidth: 1,
        borderRadius: 25,
        marginRight: 10,
        fontSize: 16,
    },
    searchButton: {
        backgroundColor: 'red',
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 25,
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
    addButton: {
        color: 'green',
        fontSize: 16,
    },
});

export default FindFriends;
