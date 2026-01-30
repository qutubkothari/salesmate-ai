/**
 * Push Notification Service for React Native Mobile App
 * Handles FCM integration for iOS and Android
 */

import messaging from '@react-native-firebase/messaging';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Platform } from 'react-native';
import api from './api';

class PushNotificationService {
  constructor() {
    this.initialized = false;
  }

  /**
   * Initialize push notifications
   * Call this on app startup after user logs in
   */
  async initialize() {
    if (this.initialized) {
      console.log('[PUSH] Already initialized');
      return;
    }

    try {
      // Request permission (iOS requires this, Android is automatic)
      const authStatus = await messaging().requestPermission();
      const enabled =
        authStatus === messaging.AuthorizationStatus.AUTHORIZED ||
        authStatus === messaging.AuthorizationStatus.PROVISIONAL;

      if (!enabled) {
        console.warn('[PUSH] Permission not granted');
        return false;
      }

      console.log('[PUSH] Permission granted:', authStatus);

      // Get FCM token
      const token = await messaging().getToken();
      console.log('[PUSH] FCM Token:', token);

      // Register token with backend
      await this.registerToken(token);

      // Set up message handlers
      this.setupMessageHandlers();

      this.initialized = true;
      return true;
    } catch (error) {
      console.error('[PUSH] Initialization failed:', error);
      return false;
    }
  }

  /**
   * Register device token with backend
   */
  async registerToken(token) {
    try {
      const platform = Platform.OS;
      
      const response = await api.post('/api/push/register', {
        deviceToken: token,
        platform
      });

      if (response.data.success) {
        console.log('[PUSH] Token registered successfully');
        await AsyncStorage.setItem('fcm_token', token);
      } else {
        console.error('[PUSH] Token registration failed:', response.data.error);
      }
    } catch (error) {
      console.error('[PUSH] Error registering token:', error);
    }
  }

  /**
   * Unregister device token (on logout)
   */
  async unregisterToken() {
    try {
      const token = await AsyncStorage.getItem('fcm_token');
      
      if (!token) {
        console.log('[PUSH] No token to unregister');
        return;
      }

      await api.post('/api/push/unregister', {
        deviceToken: token
      });

      await AsyncStorage.removeItem('fcm_token');
      this.initialized = false;
      console.log('[PUSH] Token unregistered');
    } catch (error) {
      console.error('[PUSH] Error unregistering token:', error);
    }
  }

  /**
   * Set up foreground and background message handlers
   */
  setupMessageHandlers() {
    // Foreground message handler
    messaging().onMessage(async remoteMessage => {
      console.log('[PUSH] Foreground message:', remoteMessage);
      
      // Show local notification when app is in foreground
      this.showLocalNotification(remoteMessage);
    });

    // Background message handler
    messaging().setBackgroundMessageHandler(async remoteMessage => {
      console.log('[PUSH] Background message:', remoteMessage);
    });

    // Notification opened handler (when user taps notification)
    messaging().onNotificationOpenedApp(remoteMessage => {
      console.log('[PUSH] Notification opened:', remoteMessage);
      this.handleNotificationPress(remoteMessage);
    });

    // Check if app was opened from a notification (when app was quit)
    messaging()
      .getInitialNotification()
      .then(remoteMessage => {
        if (remoteMessage) {
          console.log('[PUSH] App opened from notification:', remoteMessage);
          this.handleNotificationPress(remoteMessage);
        }
      });
  }

  /**
   * Show local notification (for foreground messages)
   */
  async showLocalNotification(remoteMessage) {
    // You can use a library like react-native-push-notification
    // or @notifee/react-native for better local notifications
    
    // For now, just log it
    console.log('[PUSH] Would show notification:', {
      title: remoteMessage.notification?.title,
      body: remoteMessage.notification?.body
    });
  }

  /**
   * Handle notification press (navigate to relevant screen)
   */
  handleNotificationPress(remoteMessage) {
    const { data } = remoteMessage;
    
    if (!data || !data.type) {
      console.log('[PUSH] No navigation data in notification');
      return;
    }

    // Navigate based on notification type
    switch (data.type) {
      case 'followup_reminder':
      case 'followup_overdue':
        // Navigate to follow-ups screen
        this.navigateToScreen('FollowupsList', {
          highlightId: data.followup_id
        });
        break;

      case 'new_message':
        // Navigate to conversation
        this.navigateToScreen('Conversation', {
          conversationId: data.conversation_id
        });
        break;

      default:
        console.log('[PUSH] Unknown notification type:', data.type);
    }
  }

  /**
   * Navigate to a screen (to be implemented with navigation ref)
   * You'll need to set this up with your navigation system
   */
  setNavigationRef(ref) {
    this.navigationRef = ref;
  }

  navigateToScreen(screenName, params = {}) {
    if (this.navigationRef) {
      this.navigationRef.navigate(screenName, params);
    } else {
      console.warn('[PUSH] Navigation ref not set');
    }
  }

  /**
   * Request permission explicitly (for settings screen)
   */
  async requestPermission() {
    try {
      const authStatus = await messaging().requestPermission();
      const enabled =
        authStatus === messaging.AuthorizationStatus.AUTHORIZED ||
        authStatus === messaging.AuthorizationStatus.PROVISIONAL;

      return enabled;
    } catch (error) {
      console.error('[PUSH] Error requesting permission:', error);
      return false;
    }
  }

  /**
   * Check if notifications are enabled
   */
  async checkPermission() {
    const authStatus = await messaging().hasPermission();
    return (
      authStatus === messaging.AuthorizationStatus.AUTHORIZED ||
      authStatus === messaging.AuthorizationStatus.PROVISIONAL
    );
  }

  /**
   * Send a test notification (development)
   */
  async sendTestNotification() {
    try {
      const response = await api.post('/api/push/test');
      console.log('[PUSH] Test notification sent:', response.data);
      return response.data;
    } catch (error) {
      console.error('[PUSH] Error sending test notification:', error);
      throw error;
    }
  }
}

export default new PushNotificationService();
