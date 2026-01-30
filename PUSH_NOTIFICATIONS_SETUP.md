# Push Notifications Setup Guide

This guide explains how to set up Firebase Cloud Messaging (FCM) for push notifications in the Salesmate mobile app.

## Prerequisites

1. **Firebase Project**: Create a project at [Firebase Console](https://console.firebase.google.com/)
2. **Android App**: Register your Android app in Firebase (package name: `com.salesmate`)
3. **iOS App**: Register your iOS app in Firebase (bundle ID: `com.salesmate`)
4. **APNs Certificate**: For iOS, upload your Apple Push Notification service certificate

## Backend Setup

### 1. Get Firebase Service Account Key

1. Go to Firebase Console → Project Settings → Service Accounts
2. Click "Generate New Private Key"
3. Download the JSON file (e.g., `salesmate-firebase-key.json`)

### 2. Set Environment Variable

Add this to your server's environment variables (or `.env` file):

```bash
FIREBASE_SERVICE_ACCOUNT_KEY='{"type":"service_account","project_id":"...","private_key_id":"...","private_key":"..."}'
```

**Note**: The value should be the entire JSON file content as a single-line string.

### 3. Install Firebase Admin SDK

```bash
cd /var/www/salesmate-ai  # Or your project directory
npm install firebase-admin
```

### 4. Run Database Migration

Execute this SQL in your Supabase SQL Editor:

```sql
-- Create device tokens table
CREATE TABLE IF NOT EXISTS salesman_devices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  salesman_id UUID NOT NULL REFERENCES salesmen(id) ON DELETE CASCADE,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  device_token TEXT NOT NULL UNIQUE,
  platform TEXT NOT NULL CHECK (platform IN ('ios', 'android')),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW(),
  last_active_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_salesman_devices_salesman ON salesman_devices(salesman_id) WHERE is_active = true;
CREATE INDEX idx_salesman_devices_tenant ON salesman_devices(tenant_id);

-- Add reminder tracking columns
ALTER TABLE conversations_new 
ADD COLUMN IF NOT EXISTS follow_up_reminder_sent_at TIMESTAMP,
ADD COLUMN IF NOT EXISTS follow_up_overdue_alert_sent_at TIMESTAMP;

CREATE INDEX idx_conversations_followup_reminders 
ON conversations_new(follow_up_at) 
WHERE follow_up_at IS NOT NULL 
  AND follow_up_completed_at IS NULL
  AND salesman_id IS NOT NULL;
```

### 5. Restart Server

```bash
pm2 restart salesmate-ai
```

## Mobile App Setup (React Native)

### 1. Install Dependencies

```bash
cd mobile-app
npm install @react-native-firebase/app @react-native-firebase/messaging
```

### 2. Android Configuration

#### a. Add Firebase Config

Download `google-services.json` from Firebase Console and place it at:
```
mobile-app/android/app/google-services.json
```

#### b. Update `android/build.gradle`

```gradle
buildscript {
  dependencies {
    classpath 'com.google.gms:google-services:4.4.0'  // Add this
  }
}
```

#### c. Update `android/app/build.gradle`

```gradle
apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services'  // Add this at the bottom
```

#### d. Update `AndroidManifest.xml`

```xml
<application>
  <!-- ... -->
  
  <!-- Firebase Messaging Service -->
  <service
    android:name="com.salesmate.messaging.MessagingService"
    android:exported="false">
    <intent-filter>
      <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
  </service>
</application>
```

### 3. iOS Configuration

#### a. Add Firebase Config

Download `GoogleService-Info.plist` from Firebase Console and add it to your Xcode project:
1. Open `mobile-app/ios/SalesmateMobile.xcworkspace` in Xcode
2. Drag `GoogleService-Info.plist` into the project

#### b. Enable Push Notifications Capability

1. In Xcode, select your project
2. Go to "Signing & Capabilities"
3. Click "+ Capability" → "Push Notifications"

#### c. Update `AppDelegate.m`

```objc
#import <Firebase.h>  // Add this

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [FIRApp configure];  // Add this
  
  // ... existing code
}

@end
```

#### d. Install Pods

```bash
cd mobile-app/ios
pod install
```

### 4. Initialize Push Notifications in App

Update your main App.js or index.js:

```javascript
import pushNotificationService from './services/pushNotificationService';

// After user logs in successfully
const onLoginSuccess = async () => {
  // ... existing login logic
  
  // Initialize push notifications
  await pushNotificationService.initialize();
};

// Set navigation reference (for deep linking)
const navigationRef = useNavigationContainerRef();

useEffect(() => {
  pushNotificationService.setNavigationRef(navigationRef);
}, [navigationRef]);
```

## Testing

### 1. Test Device Registration

1. Open the mobile app
2. Log in as a salesman
3. Go to Settings → Enable Push Notifications
4. Check server logs for: `[PUSH] Token registered successfully`

### 2. Send Test Notification

Use the Settings screen in the mobile app:
- Tap "Send Test Notification"
- You should receive a notification within seconds

### 3. Test Follow-up Reminders

Create a follow-up scheduled for 20 minutes from now. The cron job runs every 15 minutes and sends reminders for follow-ups due in the next 30 minutes.

**Manual test** (run on server):

```bash
cd /var/www/salesmate-ai
node -e "require('./services/pushNotificationService').sendDueFollowupReminders().then(console.log)"
```

## Cron Jobs

The scheduler automatically runs these push notification tasks:

1. **Follow-up Reminders** (every 15 minutes)
   - Sends notifications for follow-ups due in next 30 minutes
   - Runs during business hours (9 AM - 6 PM)

2. **Overdue Alerts** (daily at 9 AM)
   - Sends notifications for overdue follow-ups
   - Runs once per day

## API Endpoints

### Register Device Token
```http
POST /api/push/register
Authorization: Bearer <userId>
X-Tenant-Id: <tenantId>

{
  "deviceToken": "fcm_token_here",
  "platform": "android"  // or "ios"
}
```

### Unregister Device Token
```http
POST /api/push/unregister
Authorization: Bearer <userId>
X-Tenant-Id: <tenantId>

{
  "deviceToken": "fcm_token_here"
}
```

### Send Test Notification
```http
POST /api/push/test
Authorization: Bearer <userId>
X-Tenant-Id: <tenantId>
```

## Troubleshooting

### Notifications Not Received

1. **Check device registration**:
   ```sql
   SELECT * FROM salesman_devices WHERE salesman_id = '<salesman_uuid>' AND is_active = true;
   ```

2. **Check Firebase credentials**:
   ```bash
   # On server
   echo $FIREBASE_SERVICE_ACCOUNT_KEY | jq .project_id
   ```

3. **Check server logs**:
   ```bash
   pm2 logs salesmate-ai | grep PUSH
   ```

4. **Verify follow-up exists**:
   ```sql
   SELECT id, customer_id, follow_up_at, follow_up_reminder_sent_at
   FROM conversations_new
   WHERE salesman_id = '<salesman_uuid>'
     AND follow_up_at > NOW()
     AND follow_up_completed_at IS NULL;
   ```

### iOS Notifications Not Working

1. Verify APNs certificate is uploaded in Firebase Console
2. Check provisioning profile includes Push Notifications capability
3. Ensure `GoogleService-Info.plist` is added to Xcode target

### Android Notifications Not Working

1. Verify `google-services.json` is in `android/app/`
2. Check Google Play Services is installed on device/emulator
3. Rebuild app after adding Firebase config

## Production Deployment

1. **Update Firebase environment**:
   - Use production Firebase project
   - Update service account key in production environment variables

2. **Test on real devices**:
   - iOS: Test on physical iPhone (simulators don't support push)
   - Android: Test on physical device or emulator with Google Play

3. **Monitor notification delivery**:
   - Check `notification_logs` table for sent notifications
   - Monitor Firebase Console → Cloud Messaging for delivery stats

## Security Notes

- **Never commit** `google-services.json`, `GoogleService-Info.plist`, or service account keys to git
- Add them to `.gitignore`
- Store service account key securely (environment variable, secret manager)
- Rotate keys regularly
- Use separate Firebase projects for dev/staging/production
