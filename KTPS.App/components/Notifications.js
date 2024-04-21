import React, { useState, useEffect } from 'react';
import { View, Text, FlatList, RefreshControl, StyleSheet, Alert, TouchableOpacity } from 'react-native';
import AsyncStorage from "@react-native-async-storage/async-storage";
import * as Constants from '../constants.js';
import Icon from 'react-native-vector-icons/FontAwesome';
import { useIsFocused } from "@react-navigation/native";

const Notifications = ({ navigation }) => {
    const [notifications, setNotifications] = useState([]);
    const [refreshing, setRefreshing] = useState(false);
    const isFocused = useIsFocused();

    const fetchNotifications = async () => {
        const userId = await AsyncStorage.getItem("userId");
        try {
            const response = await fetch(Constants.BASE_URL + '/notification/list/' + userId);
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const responseData = await response.json();
            if (responseData.success && responseData.data) {
                const filteredNotifications = responseData.data.filter(notification => !notification.responded);
                setNotifications(filteredNotifications);
            } else {
                throw new Error('Invalid response data');
            }
        } catch (error) {
            console.error('Error fetching notifications:', error);
            Alert.alert('Error', 'An error occurred while fetching notifications. Please try again later.');
        }
    };

    const onRefresh = async () => {
        setRefreshing(true);
        await fetchNotifications();
        setRefreshing(false);
    };

    useEffect(() => {
        fetchNotifications();
    }, []);

    useEffect(() => {
        if(isFocused)
            fetchNotifications();
    }, [isFocused]);

    const handleAction = async (notificationId, actionType) => {
        try {
            const userId = await AsyncStorage.getItem('userId');
            const accept = (actionType === 'accept');
            const requestBody = {
                NotificationID: notificationId,
                UserID: userId,
                Accept: accept
            };

            const response = await fetch(Constants.BASE_URL + '/notification/respond', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(requestBody)
            });

            if (!response.ok) {
                throw new Error('Failed to send notification response');
            }

            console.log(`${accept ? 'Accepted' : 'Rejected'} notification with ID: ${notificationId}`);
        } catch (error) {
            console.error('Error handling notification action:', error);
        }
        onRefresh();
    };

    const confirmAction = (notificationId, actionType) => {
        Alert.alert(
            'Confirm Action',
            `Are you sure you want to ${actionType} this notification?`,
            [
                {
                    text: 'Cancel',
                    style: 'cancel',
                },
                {
                    text: 'OK',
                    onPress: () => handleAction(notificationId, actionType),
                },
            ]
        );
    };

    const renderNotificationItem = ({ item }) => {
        let message = '';
        if (item.type === 'Friend') {
            message = `You have a friend request from ${item.senderID}`;
        } else if (item.type === 'Group') {
            message = `You have been invited to join group ${item.groupID}`;
        } else if (item.type === 'Reminder') {
            message = `${item.senderID} is reminding you to pay in group ${item.groupID}`;
        }

        return (
            <View style={styles.notificationItem}>
                <View style={styles.notificationContent}>
                    <Text style={styles.notificationType}>{item.type} Notification</Text>
                    <Text style={styles.notificationText}>{message}</Text>
                </View>
                <View style={styles.buttonContainer}>
                    <TouchableOpacity onPress={() => confirmAction(item.id, 'accept')}>
                        <Icon name="check" size={20} color="green" style={styles.icon} />
                    </TouchableOpacity>
                    {item.type !== 'Reminder' && (
                        <TouchableOpacity onPress={() => confirmAction(item.id, 'reject')}>
                            <Icon name="times" size={20} color="red" style={styles.icon} />
                        </TouchableOpacity>
                    )}
                </View>
            </View>
        );
    };


    return (
        <View style={styles.container}>
            <FlatList
                data={notifications}
                renderItem={renderNotificationItem}
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
    notificationItem: {
        paddingVertical: 10,
        borderBottomWidth: 1,
        borderBottomColor: '#ccc',
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    notificationContent: {
        flex: 1,
        marginRight: 10,
    },
    notificationType: {
        fontSize: 16,
        fontWeight: 'bold',
        marginBottom: 5,
    },
    notificationText: {
        fontSize: 16,
    },
    buttonContainer: {
        flexDirection: 'row',
    },
    icon: {
        marginLeft: 10,
    },
});

export default Notifications;
