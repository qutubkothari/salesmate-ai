/**
 * Settings Screen - Manage push notifications
 */

import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Switch,
  TouchableOpacity,
  Alert,
  ScrollView,
  ActivityIndicator
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import pushService from '../../services/pushNotificationService';

const SettingsScreen = ({ navigation }) => {
  const [notificationsEnabled, setNotificationsEnabled] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    checkNotificationStatus();
  }, []);

  const checkNotificationStatus = async () => {
    try {
      const enabled = await pushService.checkPermission();
      setNotificationsEnabled(enabled);
    } catch (error) {
      console.error('Error checking notification status:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleToggleNotifications = async (value) => {
    if (value) {
      // Enable notifications
      setLoading(true);
      const granted = await pushService.requestPermission();
      
      if (granted) {
        await pushService.initialize();
        setNotificationsEnabled(true);
        Alert.alert('Success', 'Push notifications enabled');
      } else {
        Alert.alert(
          'Permission Denied',
          'Please enable notifications in your device settings to receive follow-up reminders.'
        );
      }
      setLoading(false);
    } else {
      // Disable notifications
      Alert.alert(
        'Disable Notifications',
        'Are you sure you want to disable push notifications? You won\'t receive follow-up reminders.',
        [
          { text: 'Cancel', style: 'cancel' },
          {
            text: 'Disable',
            style: 'destructive',
            onPress: async () => {
              setLoading(true);
              await pushService.unregisterToken();
              setNotificationsEnabled(false);
              setLoading(false);
            }
          }
        ]
      );
    }
  };

  const handleSendTestNotification = async () => {
    try {
      setLoading(true);
      await pushService.sendTestNotification();
      Alert.alert('Success', 'Test notification sent! Check your notification tray.');
    } catch (error) {
      Alert.alert('Error', 'Failed to send test notification: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Notifications</Text>
        
        <View style={styles.settingItem}>
          <View style={styles.settingLabel}>
            <Icon name="notifications" size={24} color="#007AFF" />
            <View style={styles.labelText}>
              <Text style={styles.settingTitle}>Push Notifications</Text>
              <Text style={styles.settingDescription}>
                Receive reminders for follow-ups and new messages
              </Text>
            </View>
          </View>
          {loading ? (
            <ActivityIndicator />
          ) : (
            <Switch
              value={notificationsEnabled}
              onValueChange={handleToggleNotifications}
              trackColor={{ false: '#ccc', true: '#007AFF' }}
            />
          )}
        </View>

        {notificationsEnabled && (
          <TouchableOpacity
            style={styles.testButton}
            onPress={handleSendTestNotification}
            disabled={loading}
          >
            <Icon name="send" size={20} color="#007AFF" style={styles.testButtonIcon} />
            <Text style={styles.testButtonText}>Send Test Notification</Text>
          </TouchableOpacity>
        )}
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Notification Types</Text>
        
        <View style={styles.infoItem}>
          <Icon name="access-time" size={20} color="#FF9500" />
          <Text style={styles.infoText}>Follow-up reminders (30 min before)</Text>
        </View>
        
        <View style={styles.infoItem}>
          <Icon name="warning" size={20} color="#FF3B30" />
          <Text style={styles.infoText}>Overdue follow-up alerts (daily)</Text>
        </View>
        
        <View style={styles.infoItem}>
          <Icon name="chat" size={20} color="#34C759" />
          <Text style={styles.infoText}>New customer messages</Text>
        </View>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>About</Text>
        <Text style={styles.aboutText}>
          Salesmate AI helps you manage customer relationships efficiently with smart follow-ups and automated reminders.
        </Text>
        <Text style={styles.versionText}>Version 1.0.0</Text>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5'
  },
  section: {
    backgroundColor: '#fff',
    marginTop: 20,
    paddingHorizontal: 16,
    paddingVertical: 20,
    borderTopWidth: 1,
    borderBottomWidth: 1,
    borderColor: '#E5E5E5'
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#666',
    marginBottom: 16,
    textTransform: 'uppercase',
    letterSpacing: 0.5
  },
  settingItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 8
  },
  settingLabel: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1
  },
  labelText: {
    marginLeft: 12,
    flex: 1
  },
  settingTitle: {
    fontSize: 16,
    fontWeight: '500',
    color: '#000',
    marginBottom: 4
  },
  settingDescription: {
    fontSize: 14,
    color: '#666'
  },
  testButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 16,
    padding: 12,
    backgroundColor: '#F0F8FF',
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#007AFF'
  },
  testButtonIcon: {
    marginRight: 8
  },
  testButtonText: {
    fontSize: 16,
    fontWeight: '500',
    color: '#007AFF'
  },
  infoItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#F0F0F0'
  },
  infoText: {
    marginLeft: 12,
    fontSize: 15,
    color: '#333'
  },
  aboutText: {
    fontSize: 15,
    color: '#666',
    lineHeight: 22,
    marginBottom: 12
  },
  versionText: {
    fontSize: 14,
    color: '#999',
    marginTop: 8
  }
});

export default SettingsScreen;
