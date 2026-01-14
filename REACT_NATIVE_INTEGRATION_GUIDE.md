# React Native FSM Integration Guide

Complete guide to integrate your FSM (Field Service Management) React Native app with Salesmate backend.

---

## Installation

### 1. Add API Client to Your Project

```bash
# Copy the SalesateAPIClient.js to your project
cp clients/SalesateAPIClient.js your-app/src/api/

# Or install via npm if published to npm registry
npm install @salesmate/api-client
```

### 2. Initialize in Your App

```javascript
import SalesateAPIClient from './api/SalesateAPIClient';

// At app startup
const API = new SalesateAPIClient('https://salesmate.saksolution.com');

// After user login
API.setAuthToken(userToken);

export default API;
```

---

## Authentication Flow

### Login Screen

```javascript
import React, { useState } from 'react';
import { View, TextInput, TouchableOpacity, Text } from 'react-native';
import API from './api';

export const LoginScreen = ({ navigation }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const handleLogin = async () => {
    try {
      setLoading(true);
      const response = await API.login(email, password);
      
      if (response.token) {
        API.setAuthToken(response.token);
        // Save token to AsyncStorage for persistence
        await AsyncStorage.setItem('authToken', response.token);
        navigation.navigate('Home');
      }
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <View style={styles.container}>
      <TextInput
        placeholder="Email"
        value={email}
        onChangeText={setEmail}
        style={styles.input}
      />
      <TextInput
        placeholder="Password"
        secureTextEntry
        value={password}
        onChangeText={setPassword}
        style={styles.input}
      />
      <TouchableOpacity 
        onPress={handleLogin} 
        disabled={loading}
        style={styles.button}
      >
        <Text>{loading ? 'Logging in...' : 'Login'}</Text>
      </TouchableOpacity>
      {error && <Text style={styles.error}>{error}</Text>}
    </View>
  );
};
```

---

## Visit Management

### Create Visit Screen

```javascript
import React, { useState } from 'react';
import { View, TextInput, ScrollView, TouchableOpacity, Text } from 'react-native';
import API from './api';

export const CreateVisitScreen = ({ route, navigation }) => {
  const { customerId } = route.params;
  const [visit, setVisit] = useState({
    customer_id: customerId,
    customer_name: '',
    visit_type: 'meeting',
    products_discussed: [],
    potential: 0,
    remarks: ''
  });
  const [loading, setLoading] = useState(false);

  const handleCreateVisit = async () => {
    try {
      setLoading(true);
      const response = await API.createVisit(visit);
      
      if (response.ok) {
        navigation.navigate('VisitDetails', { visitId: response.visit_id });
      }
    } catch (err) {
      alert('Error creating visit: ' + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView style={styles.container}>
      <TextInput
        placeholder="Customer Name"
        value={visit.customer_name}
        onChangeText={(text) => setVisit({ ...visit, customer_name: text })}
        style={styles.input}
      />
      
      <TextInput
        placeholder="Potential Value (₹)"
        keyboardType="numeric"
        value={visit.potential.toString()}
        onChangeText={(text) => setVisit({ ...visit, potential: parseInt(text) || 0 })}
        style={styles.input}
      />

      <TextInput
        placeholder="Remarks"
        multiline
        numberOfLines={4}
        value={visit.remarks}
        onChangeText={(text) => setVisit({ ...visit, remarks: text })}
        style={styles.input}
      />

      <TouchableOpacity 
        onPress={handleCreateVisit}
        disabled={loading}
        style={styles.button}
      >
        <Text>{loading ? 'Creating...' : 'Create Visit'}</Text>
      </TouchableOpacity>
    </ScrollView>
  );
};
```

### Complete Visit with GPS & Photos

```javascript
import React, { useState, useEffect } from 'react';
import * as Location from 'expo-location';
import * as ImagePicker from 'expo-image-picker';
import API from './api';

export const CompleteVisitScreen = ({ route, navigation }) => {
  const { visitId } = route.params;
  const [location, setLocation] = useState(null);
  const [photos, setPhotos] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // Get GPS location
    (async () => {
      let { status } = await Location.requestForegroundPermissionsAsync();
      if (status === 'granted') {
        let loc = await Location.getCurrentPositionAsync({});
        setLocation(loc.coords);
        
        // Update visit with GPS coordinates
        await API.updateVisitLocation(
          visitId,
          loc.coords.latitude,
          loc.coords.longitude,
          loc.coords.accuracy
        );
      }
    })();
  }, [visitId]);

  const pickImage = async () => {
    let result = await ImagePicker.launchCameraAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      base64: true,
    });

    if (!result.cancelled) {
      setPhotos([...photos, result.base64]);
    }
  };

  const handleCompleteVisit = async () => {
    try {
      setLoading(true);
      
      // Add images to visit
      if (photos.length > 0) {
        await API.addVisitImages(visitId, photos);
      }

      // Complete visit (triggers Phase 2 auto-actions)
      const response = await API.completeVisit(visitId, {
        time_out: new Date().toISOString(),
        remarks: 'Visit completed from mobile app',
        final_status: 'completed'
      });

      if (response.ok) {
        alert('Visit completed!\n' + 
              `Order Created: ${response.auto_actions.order_created}\n` +
              `Conversation Linked: ${response.auto_actions.conversation_linked}`);
        
        navigation.navigate('Home');
      }
    } catch (err) {
      alert('Error completing visit: ' + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <View style={styles.container}>
      <Text>GPS Location: {location ? 
        `${location.latitude.toFixed(4)}, ${location.longitude.toFixed(4)}` : 
        'Getting location...'}</Text>

      <TouchableOpacity onPress={pickImage} style={styles.button}>
        <Text>📷 Take Photo ({photos.length})</Text>
      </TouchableOpacity>

      <TouchableOpacity 
        onPress={handleCompleteVisit}
        disabled={loading || !location}
        style={styles.button}
      >
        <Text>{loading ? 'Completing...' : '✅ Complete Visit'}</Text>
      </TouchableOpacity>
    </View>
  );
};
```

---

## Customer & Order Management

### Search Customer

```javascript
export const SearchCustomerScreen = ({ navigation }) => {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(false);

  const handleSearch = async (text) => {
    setQuery(text);
    if (text.length > 2) {
      setLoading(true);
      try {
        const response = await API.searchCustomers(text);
        setResults(response.customers || []);
      } finally {
        setLoading(false);
      }
    }
  };

  return (
    <View style={styles.container}>
      <TextInput
        placeholder="Search customers..."
        value={query}
        onChangeText={handleSearch}
        style={styles.input}
      />
      
      {loading && <Text>Searching...</Text>}
      
      {results.map((customer) => (
        <TouchableOpacity
          key={customer.id}
          onPress={() => navigation.navigate('CreateVisit', { customerId: customer.id })}
          style={styles.resultItem}
        >
          <Text style={styles.customerName}>{customer.business_name}</Text>
          <Text style={styles.customerPhone}>{customer.phone}</Text>
        </TouchableOpacity>
      ))}
    </View>
  );
};
```

### View Orders

```javascript
export const OrdersScreen = ({ navigation }) => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        const user = await API.getCurrentUser();
        const response = await API.getSalesmanVisits(user.id);
        // Get orders from visits with products
        const visitsWithProducts = response.visits.filter(v => v.products_discussed?.length > 0);
        setOrders(visitsWithProducts);
      } finally {
        setLoading(false);
      }
    };

    fetchOrders();
  }, []);

  if (loading) return <Text>Loading orders...</Text>;

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.header}>My Orders (Auto-Created from Visits)</Text>
      {orders.map((order) => (
        <TouchableOpacity
          key={order.id}
          style={styles.orderCard}
          onPress={() => navigation.navigate('OrderDetails', { orderId: order.id })}
        >
          <Text style={styles.orderTitle}>{order.customer_name}</Text>
          <Text>Products: {order.products_discussed?.length || 0}</Text>
          <Text>Potential: ₹{order.potential?.toLocaleString()}</Text>
          <Text style={styles.orderStatus}>{order.status}</Text>
        </TouchableOpacity>
      ))}
    </ScrollView>
  );
};
```

---

## Target & Performance Tracking

### View Targets

```javascript
export const TargetsScreen = ({ navigation }) => {
  const [targets, setTargets] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchTargets = async () => {
      try {
        const user = await API.getCurrentUser();
        const response = await API.getSalesmanTargets(user.id);
        setTargets(response.target);
      } finally {
        setLoading(false);
      }
    };

    fetchTargets();
    const interval = setInterval(fetchTargets, 300000); // Refresh every 5 minutes
    return () => clearInterval(interval);
  }, []);

  if (loading) return <Text>Loading targets...</Text>;
  if (!targets) return <Text>No targets set for this period</Text>;

  const visitProgress = (targets.achieved_visits / targets.target_visits) * 100;
  const orderProgress = (targets.achieved_orders / targets.target_orders) * 100;
  const revenueProgress = (targets.achieved_revenue / targets.target_revenue) * 100;

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.header}>My Targets - {targets.period}</Text>

      <ProgressCard
        label="Visits"
        achieved={targets.achieved_visits}
        target={targets.target_visits}
        progress={visitProgress}
      />

      <ProgressCard
        label="Orders"
        achieved={targets.achieved_orders}
        target={targets.target_orders}
        progress={orderProgress}
      />

      <ProgressCard
        label="Revenue"
        achieved={`₹${targets.achieved_revenue.toLocaleString()}`}
        target={`₹${targets.target_revenue.toLocaleString()}`}
        progress={revenueProgress}
      />
    </ScrollView>
  );
};

const ProgressCard = ({ label, achieved, target, progress }) => (
  <View style={styles.progressCard}>
    <Text style={styles.progressLabel}>{label}</Text>
    <View style={styles.progressBar}>
      <View style={[styles.progressFill, { width: `${progress}%` }]} />
    </View>
    <Text style={styles.progressText}>
      {achieved} / {target} ({Math.round(progress)}%)
    </Text>
  </View>
);
```

---

## Error Handling

```javascript
// Wrap API calls with error handling
const safeAPICall = async (apiFunction, errorMessage) => {
  try {
    return await apiFunction();
  } catch (error) {
    const { error: friendlyError } = SalesateAPIClient.handleError(error);
    alert(friendlyError);
    return null;
  }
};

// Usage
const result = await safeAPICall(
  () => API.createVisit(visitData),
  'Failed to create visit'
);
```

---

## Offline Support (Optional)

```javascript
import AsyncStorage from '@react-native-async-storage/async-storage';

class OfflineAPIClient extends SalesateAPIClient {
  async request(method, endpoint, body = null, options = {}) {
    try {
      // Try online
      return await super.request(method, endpoint, body, options);
    } catch (error) {
      // Fall back to offline storage
      if (method === 'POST' || method === 'PUT') {
        const queue = await AsyncStorage.getItem('apiQueue') || '[]';
        const requests = JSON.parse(queue);
        requests.push({ method, endpoint, body });
        await AsyncStorage.setItem('apiQueue', JSON.stringify(requests));
        return { ok: true, offline: true };
      }
      throw error;
    }
  }

  async syncOfflineRequests() {
    const queue = await AsyncStorage.getItem('apiQueue') || '[]';
    const requests = JSON.parse(queue);

    for (const req of requests) {
      try {
        await super.request(req.method, req.endpoint, req.body);
      } catch (error) {
        console.error('Sync error:', error);
      }
    }

    await AsyncStorage.setItem('apiQueue', '[]');
  }
}
```

---

## Complete Integration Example

```javascript
// App.js
import React, { useEffect, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import AsyncStorage from '@react-native-async-storage/async-storage';
import API from './api/SalesateAPIClient';

import LoginScreen from './screens/LoginScreen';
import HomeScreen from './screens/HomeScreen';
import CreateVisitScreen from './screens/CreateVisitScreen';
import CompleteVisitScreen from './screens/CompleteVisitScreen';

const Stack = createNativeStackNavigator();

export default function App() {
  const [authenticated, setAuthenticated] = useState(null);

  useEffect(() => {
    // Restore token on app start
    (async () => {
      const token = await AsyncStorage.getItem('authToken');
      if (token) {
        API.setAuthToken(token);
        setAuthenticated(true);
      } else {
        setAuthenticated(false);
      }
    })();
  }, []);

  if (authenticated === null) {
    return <Text>Loading...</Text>;
  }

  return (
    <NavigationContainer>
      <Stack.Navigator>
        {!authenticated ? (
          <Stack.Screen 
            name="Login" 
            component={LoginScreen}
            options={{ headerShown: false }}
          />
        ) : (
          <>
            <Stack.Screen 
              name="Home" 
              component={HomeScreen}
              options={{ title: 'Salesmate Field App' }}
            />
            <Stack.Screen 
              name="CreateVisit" 
              component={CreateVisitScreen}
              options={{ title: 'New Visit' }}
            />
            <Stack.Screen 
              name="CompleteVisit" 
              component={CompleteVisitScreen}
              options={{ title: 'Complete Visit' }}
            />
          </>
        )}
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

---

## Key Points

✅ **Auto-Actions on Visit Completion:**
- Order automatically created (draft status)
- Conversation linked with field context
- Targets synced for AI enrichment

✅ **Real-Time Features:**
- GPS location tracking during visit
- Photo capture and upload
- Instant order creation
- Achievement auto-recording

✅ **Data Sync:**
- Token refresh on expiration
- Offline queue support
- Background location updates

✅ **Security:**
- JWT token authentication
- Role-based access (salesman/manager)
- HTTPS only (production)
- Secure token storage

---

## Testing Checklist

- [ ] Login with valid credentials
- [ ] Search and create customer
- [ ] Create visit with products
- [ ] Update GPS location during visit
- [ ] Capture and upload photos
- [ ] Complete visit and verify order created
- [ ] Check conversation enrichment
- [ ] View targets and progress
- [ ] Test offline functionality
- [ ] Verify token refresh

---

## Support & Debugging

Enable API logging:
```javascript
const API = new SalesateAPIClient('https://salesmate.saksolution.com');
// Add logging in SalesateAPIClient.request() method
```

Check server logs:
```bash
pm2 logs salesmate-ai
```

---

**Documentation Version:** 1.0  
**Last Updated:** January 14, 2026  
**Status:** ✅ Production Ready
