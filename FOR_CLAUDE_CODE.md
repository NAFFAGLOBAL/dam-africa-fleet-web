# Instructions for Claude Code

## ✅ Repo Ready on GitHub

**Repository:** https://github.com/NAFFAGLOBAL/dam-africa-fleet-web  
**Status:** Private, all specs pushed  
**Branch:** main

---

## 🚀 Your Mission: Build Phase 1

### Step 1: Clone the Repo
```bash
cd ~
git clone https://github.com/NAFFAGLOBAL/dam-africa-fleet-web.git
cd dam-africa-fleet-web
```

### Step 2: Read the Specs
**MUST READ (in order):**
1. `README.md` - Overview & quick start
2. `mobile-app-specs.md` - **Complete technical specifications (15+ pages)**
3. `docs/WEB_FIRST_STRATEGY.md` - Deployment approach

**Important files:**
- `SETUP.md` - Flutter installation if needed
- `PROJECT_STATUS.md` - Current status

### Step 3: Build Phase 1

**Create Flutter project in `fleet-web/` directory:**

```bash
# From repo root
flutter create --platforms=web,android,ios fleet-web
cd fleet-web
```

**Add dependencies:**
```bash
flutter pub add riverpod flutter_riverpod http go_router flutter_secure_storage shared_preferences
flutter pub add --dev flutter_lints
```

**Build these features** (follow mobile-app-specs.md exactly):

#### 1. Authentication System
- [ ] Login screen (email/password, responsive)
- [ ] Email input with validation
- [ ] Password input with visibility toggle
- [ ] Mock authentication (any credentials work)
- [ ] JWT token storage (FlutterSecureStorage)
- [ ] Auth state management (Riverpod)
- [ ] Loading states & error handling

#### 2. Admin Dashboard (Desktop-Optimized)
- [ ] AppBar with "Fleet Overview" title
- [ ] Notifications bell icon (with badge)
- [ ] Stats cards in 2x2 grid:
  - Total Vehicles (45)
  - Active Trips (12)
  - Maintenance Due (3)
  - Alerts (5)
- [ ] Quick action buttons (horizontal): Track, Add Trip, Reports
- [ ] Recent activity list (scrollable)

#### 3. Driver Dashboard (Mobile-Optimized)
- [ ] Welcome header with user name
- [ ] Current vehicle badge
- [ ] Current trip card (if active):
  - Start location
  - Destination
  - Status indicator
  - Start/End trip button
- [ ] Today's schedule section
- [ ] Vehicle status section:
  - Fuel level
  - Odometer
  - Next maintenance

#### 4. Core Infrastructure
- [ ] Responsive layout widget (breakpoints: 600px mobile, 1024px desktop)
- [ ] API service with mock data (USE_MOCK_DATA = true in constants.dart)
- [ ] GoRouter setup: /splash → /login → /dashboard
- [ ] Material 3 theme:
  - Primary: #1E88E5 (blue)
  - Secondary: #43A047 (green)
  - Card radius: 12px
  - Button radius: 8px
- [ ] StatCard widget (reusable)
- [ ] Loading indicator widget
- [ ] Error handling throughout

#### 5. Project Structure
```
fleet-web/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── config/
│   │   ├── theme.dart
│   │   ├── routes.dart
│   │   └── constants.dart (USE_MOCK_DATA = true)
│   ├── models/
│   │   ├── user.dart (id, name, email, role, phone)
│   │   ├── vehicle.dart
│   │   ├── trip.dart
│   │   └── dashboard_stats.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── dashboard_provider.dart
│   ├── services/
│   │   ├── api_service.dart (with mock data fallback)
│   │   ├── auth_service.dart
│   │   └── storage_service.dart
│   ├── screens/
│   │   ├── auth/
│   │   │   └── login_screen.dart
│   │   ├── dashboard/
│   │   │   ├── admin_dashboard.dart
│   │   │   └── driver_dashboard.dart
│   │   └── splash_screen.dart
│   └── widgets/
│       ├── responsive_layout.dart
│       ├── stat_card.dart
│       └── loading_indicator.dart
├── web/
│   ├── index.html
│   └── manifest.json
└── pubspec.yaml
```

### Step 4: Quality Standards

**Apple-Standard UX Requirements:**
- [ ] Smooth 300ms transitions
- [ ] Consistent 8px base spacing
- [ ] No errors: `flutter analyze` = 0 issues
- [ ] No warnings
- [ ] Responsive on 390px mobile and 1920px desktop
- [ ] 60fps performance
- [ ] Professional typography (Material 3)
- [ ] Loading states for all async operations
- [ ] Inline error messages (not dialogs)

### Step 5: Test & Run

```bash
# Run in Chrome
flutter run -d chrome

# Build for deployment
flutter build web --release --web-renderer canvaskit
```

**Success criteria:**
1. ✅ Login screen works (responsive)
2. ✅ Mock login succeeds with any credentials
3. ✅ Admin dashboard shows stats & activity
4. ✅ Driver dashboard shows trip & schedule
5. ✅ Window resize adapts layout smoothly
6. ✅ No console errors
7. ✅ Runs at 60fps

### Step 6: Commit & Push

```bash
git add fleet-web/
git commit -m "feat: Phase 1 - Auth + Dashboards (web foundation)"
git push origin main
```

---

## 📋 Mock Data Examples

### Mock User (Admin)
```dart
User(
  id: 'admin-001',
  name: 'Mamadou Diallo',
  email: 'admin@damafrica.com',
  role: 'admin',
  phone: '+14437684409',
)
```

### Mock User (Driver)
```dart
User(
  id: 'driver-001',
  name: 'Kofi Mensah',
  email: 'kofi@damafrica.com',
  role: 'driver',
  phone: '+2250123456789',
)
```

### Mock Dashboard Stats
```dart
DashboardStats(
  totalVehicles: 45,
  activeTrips: 12,
  maintenanceDue: 3,
  alerts: 5,
  recentActivity: [
    Activity(type: 'trip_started', title: 'Trip #123 started', vehicle: 'Truck 5'),
    Activity(type: 'maintenance', title: 'Maintenance scheduled', vehicle: 'Van 12'),
    Activity(type: 'alert', title: 'Low fuel', vehicle: 'Car 8'),
  ],
)
```

---

## 🎯 Key Points

1. **Follow mobile-app-specs.md religiously** - it has every detail
2. **USE_MOCK_DATA = true** - no backend needed yet
3. **Responsive is critical** - test on mobile and desktop
4. **Material 3 theme** - use modern Flutter components
5. **Apple-standard quality** - smooth, professional, no jank
6. **Comment your code** - future developers will thank you

---

## 🆘 If You Get Stuck

**Check these sections in mobile-app-specs.md:**
- Authentication Flow (page 2)
- Screen Specifications (pages 3-8)
- State Management Strategy (page 9)
- UI/UX Guidelines (page 11)

**Common issues:**
- Flutter not installed? See SETUP.md
- Routing issues? Check routes.dart example in specs
- Responsive not working? Use LayoutBuilder (see specs)

---

## ✅ When Complete

**Notify via:**
```bash
openclaw gateway wake --text "Phase 1 Complete: Flutter web app built. Login + dashboards working. Pushed to GitHub." --mode now
```

**Or just commit and push** - Mamadou will check GitHub.

---

## 🎨 Design Reference

**Colors:**
- Primary: #1E88E5 (Material Blue)
- Secondary: #43A047 (Material Green)
- Error: #E53935 (Material Red)
- Warning: #FB8C00 (Material Orange)
- Background: #F5F5F5
- Surface: #FFFFFF
- Text Primary: #212121
- Text Secondary: #757575

**Typography:**
- Headline 1: 24sp, bold
- Headline 2: 20sp, semi-bold
- Body 1: 16sp, regular
- Body 2: 14sp, regular
- Caption: 12sp, secondary color

---

**Ready to build! Follow the specs and create something amazing!** 🚀
