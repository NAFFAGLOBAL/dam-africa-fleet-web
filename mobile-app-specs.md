# DAM Africa Fleet Management - Mobile App Specifications

## Overview
Premium Flutter mobile app for DAM Africa Fleet Management system. Target: iOS & Android with Apple-standard UX quality.

## Tech Stack
- **Framework:** Flutter 3.x
- **State Management:** Riverpod (recommended) or Bloc
- **API:** REST (existing backend) + Socket.io for real-time
- **Maps:** Google Maps Flutter
- **Auth:** JWT tokens (stored in secure storage)
- **Local Storage:** Hive or sqflite
- **Push Notifications:** Firebase Cloud Messaging

---

## App Architecture

### User Roles
1. **Admin** - Full system access, fleet management
2. **Driver** - Vehicle assignment, trip tracking, document access

### Core Features Matrix

| Feature | Admin | Driver |
|---------|-------|--------|
| Dashboard | ✓ | ✓ |
| Real-time Vehicle Tracking | ✓ | Own vehicle |
| Trip Management | ✓ | Own trips |
| Maintenance Scheduling | ✓ | View only |
| Document Management | ✓ | Own documents |
| Alerts & Notifications | ✓ | ✓ |
| Reports & Analytics | ✓ | Limited |
| User Management | ✓ | - |

---

## Authentication Flow

### Login Screen
```dart
// API Endpoint: POST /api/auth/login
{
  "email": "user@example.com",
  "password": "password"
}

// Response:
{
  "token": "jwt_token",
  "user": {
    "id": "uuid",
    "name": "string",
    "email": "string",
    "role": "admin" | "driver",
    "phone": "string",
    "avatar_url": "string"
  }
}
```

### Token Management
- Store JWT in secure storage (flutter_secure_storage)
- Auto-refresh on 401 responses
- Logout clears token + local cache

### Biometric (Optional Enhancement)
- Face ID / Touch ID for quick login
- Store encrypted credentials locally

---

## Screen Specifications

### 1. Splash Screen
- **Duration:** 2 seconds
- **Content:** DAM Africa logo with subtle animation
- **Logic:** Check auth token → navigate to Dashboard or Login

### 2. Login Screen
- **Layout:** 
  - Logo (top 30%)
  - Email input (email keyboard)
  - Password input (obscured, toggle visibility)
  - "Forgot Password?" link
  - Primary button: "Sign In"
  - Loading state during API call
- **Validation:**
  - Email format check
  - Password min 6 characters
  - Show error messages inline
- **UX:** 
  - Auto-focus email field
  - Keyboard dismissal on tap outside
  - Error states with clear messaging

### 3. Dashboard (Admin)

#### Layout
```
┌─────────────────────────────┐
│ Header: "Fleet Overview"    │
│ Notifications bell (badge)  │
├─────────────────────────────┤
│ Stats Cards (2x2 grid)      │
│ - Total Vehicles            │
│ - Active Trips              │
│ - Maintenance Due           │
│ - Alerts                    │
├─────────────────────────────┤
│ Quick Actions (horizontal)  │
│ [Track] [Add Trip] [Reports]│
├─────────────────────────────┤
│ Recent Activity List        │
│ (scrollable)                │
└─────────────────────────────┘
```

#### API Endpoints
```dart
// Dashboard Stats
GET /api/dashboard/stats
Response:
{
  "total_vehicles": 45,
  "active_trips": 12,
  "maintenance_due": 3,
  "alerts": 5,
  "recent_activity": [
    {
      "id": "uuid",
      "type": "trip_started" | "maintenance_scheduled" | "alert",
      "title": "string",
      "description": "string",
      "timestamp": "ISO8601",
      "vehicle_id": "uuid"
    }
  ]
}
```

### 4. Dashboard (Driver)

#### Layout
```
┌─────────────────────────────┐
│ Header: "Welcome, [Name]"   │
│ Current vehicle badge       │
├─────────────────────────────┤
│ Current Trip Card (if any)  │
│ - Start location            │
│ - Destination               │
│ - Status                    │
│ - [Start Trip] / [End Trip] │
├─────────────────────────────┤
│ Today's Schedule            │
│ (upcoming trips)            │
├─────────────────────────────┤
│ Vehicle Status              │
│ - Fuel level                │
│ - Odometer                  │
│ - Next maintenance          │
└─────────────────────────────┘
```

### 5. Real-time Map Screen

#### Features
- Google Maps with vehicle markers
- Color-coded by status (green=active, yellow=idle, red=alert)
- Tap marker → vehicle info bottom sheet
- Filter by vehicle type, status
- Search vehicles
- Route polylines for active trips

#### API
```dart
// Vehicle Locations (Socket.io)
socket.on('vehicle_location_update', (data) {
  // data: { vehicle_id, lat, lng, speed, heading, timestamp }
});

// Or REST fallback
GET /api/vehicles/locations
Response:
{
  "vehicles": [
    {
      "id": "uuid",
      "name": "string",
      "type": "string",
      "status": "active" | "idle" | "maintenance" | "alert",
      "location": {
        "lat": 37.7749,
        "lng": -122.4194,
        "speed": 45.5,
        "heading": 180,
        "timestamp": "ISO8601"
      }
    }
  ]
}
```

### 6. Vehicle List Screen

#### Layout
- Search bar at top
- Filter chips (All, Active, Idle, Maintenance)
- List of vehicle cards:
  ```
  ┌────────────────────────────┐
  │ [Icon] Vehicle Name        │
  │ Type: Truck | Status: ●    │
  │ Driver: Name or Unassigned │
  │ Last update: 2 min ago     │
  └────────────────────────────┘
  ```
- Pull-to-refresh
- Tap card → Vehicle Detail Screen

### 7. Vehicle Detail Screen

#### Tabs
1. **Overview**
   - Make, Model, Year
   - License Plate
   - VIN
   - Current Driver
   - Status
   - Location (mini map)

2. **Trips**
   - List of trips (past 30 days)
   - Each trip: date, route, distance, duration
   - Tap → Trip Detail

3. **Maintenance**
   - Service history
   - Upcoming maintenance
   - Add maintenance record (Admin only)

4. **Documents**
   - Registration, Insurance, Inspection
   - Upload/view PDFs/images
   - Expiry tracking with alerts

#### API
```dart
GET /api/vehicles/:id
Response:
{
  "id": "uuid",
  "name": "string",
  "type": "string",
  "make": "string",
  "model": "string",
  "year": 2022,
  "license_plate": "string",
  "vin": "string",
  "status": "string",
  "current_driver": { "id": "uuid", "name": "string" },
  "location": { "lat": float, "lng": float, "timestamp": "ISO8601" },
  "trips": [ /* trip objects */ ],
  "maintenance_records": [ /* maintenance objects */ ],
  "documents": [ /* document objects */ ]
}
```

### 8. Trip Management Screen (Admin)

#### Features
- Create trip form:
  - Vehicle selection (dropdown with search)
  - Driver selection
  - Start location (map picker or autocomplete)
  - Destination
  - Scheduled start time
  - Notes
- Active trips list
- Completed trips list

#### API
```dart
POST /api/trips
{
  "vehicle_id": "uuid",
  "driver_id": "uuid",
  "start_location": { "lat": float, "lng": float, "address": "string" },
  "destination": { "lat": float, "lng": float, "address": "string" },
  "scheduled_start": "ISO8601",
  "notes": "string"
}

GET /api/trips?status=active|completed&limit=50
```

### 9. Notifications Screen

#### Layout
- List of notifications (newest first)
- Badge on unread
- Swipe to dismiss
- Tap → relevant screen (vehicle, trip, etc.)

#### Types
- Maintenance due
- Trip started/completed
- Alert triggered (speeding, geofence, etc.)
- Document expiring soon

#### API
```dart
GET /api/notifications?unread_only=true
Response:
{
  "notifications": [
    {
      "id": "uuid",
      "type": "maintenance" | "trip" | "alert" | "document",
      "title": "string",
      "message": "string",
      "timestamp": "ISO8601",
      "read": false,
      "data": { /* context for navigation */ }
    }
  ]
}

PUT /api/notifications/:id/read
```

### 10. Settings Screen

#### Options
- Profile (edit name, email, phone, avatar)
- Change password
- Notification preferences (toggle types)
- Language (future)
- Dark mode toggle
- App version
- Logout

---

## State Management Strategy

### Recommended: Riverpod

```dart
// Example provider structure
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(...);
final vehiclesProvider = FutureProvider<List<Vehicle>>(...);
final dashboardStatsProvider = FutureProvider<DashboardStats>(...);
final socketProvider = Provider<SocketService>(...);
```

### Key States
1. **Auth State:** logged in/out, user object, token
2. **Vehicles State:** list, selected vehicle, filters
3. **Trips State:** active trips, trip history
4. **Notifications State:** unread count, list
5. **Settings State:** preferences

---

## Real-time Updates

### Socket.io Events

```dart
// Connect on login
socket.connect(
  'https://api.damafrica.com',
  options: SocketIOOptions(
    auth: {'token': jwtToken}
  )
);

// Subscribe to events
socket.on('vehicle_location_update', handleLocationUpdate);
socket.on('trip_status_change', handleTripUpdate);
socket.on('new_alert', handleAlert);
socket.on('notification', handleNotification);

// Disconnect on logout
socket.disconnect();
```

### Fallback Strategy
- If socket disconnects, switch to polling every 30s
- Show connection status indicator
- Auto-reconnect on network recovery

---

## Push Notifications

### Firebase Setup
1. Configure FCM for iOS & Android
2. Send device token to backend on login
3. Backend sends notifications via FCM

### Backend Endpoint
```dart
POST /api/devices/register
{
  "device_token": "fcm_token",
  "platform": "ios" | "android"
}
```

### Notification Handling
- Foreground: Show in-app alert
- Background: System notification → open app to relevant screen

---

## Offline Support

### Critical Features
1. **Cache dashboard stats** (show stale data with indicator)
2. **Cache last known vehicle locations**
3. **Queue actions** (e.g., trip start/end) for sync when online
4. **Offline indicator** in UI

### Implementation
```dart
// Hive for local storage
await Hive.initFlutter();
final vehiclesBox = await Hive.openBox<Vehicle>('vehicles');

// Check connectivity
final connectivity = Connectivity();
connectivity.onConnectivityChanged.listen((result) {
  // Update offline state
});
```

---

## UI/UX Guidelines

### Design System

#### Colors
```dart
// Light theme
primary: Color(0xFF1E88E5),        // Blue
secondary: Color(0xFF43A047),      // Green
error: Color(0xFFE53935),          // Red
warning: Color(0xFFFB8C00),        // Orange
background: Color(0xFFF5F5F5),     // Light gray
surface: Color(0xFFFFFFFF),        // White
textPrimary: Color(0xFF212121),    // Dark gray
textSecondary: Color(0xFF757575),  // Medium gray

// Dark theme (optional)
// ...
```

#### Typography
```dart
headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
body1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
body2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
caption: TextStyle(fontSize: 12, color: textSecondary),
```

#### Spacing
- Base unit: 8px
- Padding: 16px (2 units)
- Margin: 8px, 16px, 24px
- Card radius: 12px
- Button radius: 8px

### Animation Standards
- Page transitions: 300ms ease-in-out
- Button press: scale 0.95, 150ms
- Loading states: shimmer or circular progress
- List item animations: staggered fade-in

### Accessibility
- Minimum tap target: 48x48px
- Color contrast ratio: 4.5:1
- Screen reader support (Semantics widget)
- Font scaling support

---

## Testing Strategy

### Unit Tests
- API service methods
- State management logic
- Utility functions

### Widget Tests
- Login form validation
- Dashboard stat cards
- Vehicle list filtering

### Integration Tests
- Login flow
- Trip creation flow
- Notification handling

---

## Performance Optimization

1. **Image Optimization**
   - Use `cached_network_image` for avatars, vehicle images
   - Compress uploads before sending

2. **List Performance**
   - Use `ListView.builder` for large lists
   - Implement pagination (50 items per page)

3. **Map Performance**
   - Cluster markers when zoomed out
   - Limit visible markers to viewport

4. **State Updates**
   - Debounce socket updates (max 1/second per vehicle)
   - Use `const` constructors where possible

---

## Security Checklist

- ✅ JWT stored in secure storage (not shared preferences)
- ✅ HTTPS only (no HTTP fallback)
- ✅ Certificate pinning (production)
- ✅ Obfuscate code in release build
- ✅ No sensitive data in logs
- ✅ Validate all user inputs
- ✅ Handle API errors gracefully

---

## Deployment Checklist

### Pre-release
1. Update version in `pubspec.yaml` (semantic versioning)
2. Run `flutter analyze` (0 errors/warnings)
3. Run test suite (100% pass)
4. Test on iOS & Android physical devices
5. Check all third-party licenses

### iOS
1. Configure bundle ID, signing certificates
2. Update `Info.plist` (permissions, URLs)
3. Generate screenshots for App Store
4. Submit to TestFlight → App Store

### Android
1. Configure signing keystore
2. Update `AndroidManifest.xml` (permissions)
3. Generate signed APK/AAB
4. Submit to Play Console

---

## Future Enhancements (Phase 2)

1. **Geofencing** - Alerts when vehicles enter/exit zones
2. **Route Optimization** - AI-suggested routes
3. **Fuel Tracking** - Consumption analytics
4. **Driver Performance Scoring** - Speed, braking, efficiency
5. **Voice Commands** - "Show me vehicle 42"
6. **Offline Maps** - Download for use without connectivity
7. **Multi-language** - Localization support
8. **Apple Watch / Wear OS** - Companion apps

---

## API Base URLs

```dart
// Environment-based config
const String API_BASE_URL = String.fromEnvironment(
  'API_URL',
  defaultValue: 'https://api.damafrica.com'
);

const String SOCKET_URL = String.fromEnvironment(
  'SOCKET_URL',
  defaultValue: 'https://api.damafrica.com'
);
```

---

## File Structure

```
lib/
├── main.dart
├── app.dart
├── config/
│   ├── theme.dart
│   ├── routes.dart
│   └── constants.dart
├── models/
│   ├── user.dart
│   ├── vehicle.dart
│   ├── trip.dart
│   ├── notification.dart
│   └── ...
├── providers/
│   ├── auth_provider.dart
│   ├── vehicles_provider.dart
│   ├── trips_provider.dart
│   └── ...
├── services/
│   ├── api_service.dart
│   ├── socket_service.dart
│   ├── storage_service.dart
│   ├── notification_service.dart
│   └── ...
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── forgot_password_screen.dart
│   ├── dashboard/
│   │   ├── admin_dashboard.dart
│   │   └── driver_dashboard.dart
│   ├── vehicles/
│   │   ├── vehicles_screen.dart
│   │   ├── vehicle_detail_screen.dart
│   │   └── vehicle_map_screen.dart
│   ├── trips/
│   │   ├── trips_screen.dart
│   │   ├── trip_detail_screen.dart
│   │   └── create_trip_screen.dart
│   └── ...
├── widgets/
│   ├── stat_card.dart
│   ├── vehicle_card.dart
│   ├── trip_card.dart
│   └── ...
└── utils/
    ├── formatters.dart
    ├── validators.dart
    └── ...
```

---

## Getting Started

### Prerequisites
```bash
flutter --version  # 3.16.0 or higher
dart --version     # 3.2.0 or higher
```

### Setup
```bash
# Clone repo (once created)
git clone https://github.com/damafrica/mobile-app.git
cd mobile-app

# Install dependencies
flutter pub get

# Run on iOS
flutter run -d ios

# Run on Android
flutter run -d android

# Build release
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

### Environment Variables
Create `.env` file:
```
API_URL=https://api.damafrica.com
SOCKET_URL=https://api.damafrica.com
GOOGLE_MAPS_API_KEY_IOS=your_key
GOOGLE_MAPS_API_KEY_ANDROID=your_key
```

---

**End of Specifications**

Next steps:
1. Review & approve these specs
2. Initialize Flutter project with this structure
3. Begin implementation phase by phase (Auth → Dashboard → Vehicles → Trips → ...)
