# DAM Africa Fleet Management - Version 2 (Clean Build)

**Status:** Phase 1 - Foundation Development  
**Approach:** Web-first (PWA) → Native Mobile  
**Tech Stack:** Flutter Web + Riverpod + Material 3

---

## 📚 Project Documentation

### For Developers
- **[SETUP.md](SETUP.md)** - Flutter installation & project setup
- **[mobile-app-specs.md](mobile-app-specs.md)** - Complete technical specifications (15+ pages)
- **[docs/WEB_FIRST_STRATEGY.md](docs/WEB_FIRST_STRATEGY.md)** - Deployment strategy & timeline

### For Customer
- **[docs/CUSTOMER_API_GUIDE.md](docs/CUSTOMER_API_GUIDE.md)** - API information request form

### Project Status
- **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current status & next steps

---

## 🎯 Quick Start (For Claude Code or Human Developers)

### Prerequisites
```bash
flutter --version  # 3.16.0 or higher required
flutter config --enable-web
```

### Build Phase 1 (Foundation)
```bash
# Create Flutter project
flutter create --platforms=web,android,ios fleet-web
cd fleet-web

# Add dependencies (see mobile-app-specs.md for full list)
flutter pub add riverpod flutter_riverpod http go_router flutter_secure_storage shared_preferences

# Run in browser
flutter run -d chrome

# Build for deployment
flutter build web --release
```

---

## 📋 Phase 1 Requirements

Build these features following **mobile-app-specs.md**:

### Authentication System
- [ ] Login screen (responsive: mobile + desktop)
- [ ] Email/password inputs with validation
- [ ] Mock authentication (any credentials work for now)
- [ ] JWT token storage (FlutterSecureStorage)
- [ ] Auth state management (Riverpod)

### Dashboard Screens
- [ ] Admin Dashboard (desktop-optimized layout)
  - Stats cards: Total Vehicles, Active Trips, Maintenance, Alerts
  - Quick action buttons
  - Recent activity list
- [ ] Driver Dashboard (mobile-optimized layout)
  - Welcome header with user info
  - Current trip card
  - Today's schedule
  - Vehicle status

### Core Infrastructure
- [ ] Responsive layout system (breakpoints: 600px, 1024px)
- [ ] API service with mock data fallback (USE_MOCK_DATA = true)
- [ ] Routing (GoRouter): /splash → /login → /dashboard
- [ ] Material 3 theme (primary: #1E88E5, cards: 12px radius)
- [ ] Loading states & error handling

---

## 🎨 Design Standards

**Quality Target:** Apple-standard UX
- Smooth animations (300ms transitions)
- Consistent spacing (8px base unit)
- Professional typography (Material 3)
- 60fps performance
- No janky scrolling

---

## 📊 Mock Data (Phase 1)

App works without backend using mock data:
- 45 total vehicles
- 12 active trips
- 3 maintenance items due
- 5 alerts pending

**When customer provides API info** → replace mock with real endpoints.

---

## 🚀 Deployment Strategy

### Week 1: Web App
Deploy to Vercel/Netlify for immediate customer testing

### Week 2: PWA
Add service worker, manifest.json for installable mobile web app

### Week 3-4: Native Apps
Compile same codebase to iOS/Android

---

## 📁 Expected Project Structure

```
fleet-web/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── config/
│   │   ├── theme.dart
│   │   ├── routes.dart
│   │   └── constants.dart
│   ├── models/
│   │   ├── user.dart
│   │   ├── vehicle.dart
│   │   ├── trip.dart
│   │   └── dashboard_stats.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── dashboard_provider.dart
│   ├── services/
│   │   ├── api_service.dart
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
├── pubspec.yaml
└── README.md
```

---

## ✅ Phase 1 Success Criteria

App is ready when:
1. Can open in Chrome/Safari browser
2. Login screen works (responsive on mobile + desktop)
3. Mock login succeeds with any credentials
4. Admin dashboard shows stats and recent activity
5. Driver dashboard shows trip info and schedule
6. Window resize adapts layout smoothly
7. `flutter analyze` shows 0 errors/warnings
8. Runs at 60fps without jank

---

## 🔄 After Phase 1

1. Customer sends API info (via CUSTOMER_API_GUIDE.md)
2. Replace mock data with real API calls
3. Deploy to Vercel for customer testing
4. Gather feedback
5. Move to Phase 2: Vehicles + Real-time Map

---

## 📞 Support

**Questions?** Check the comprehensive specs in **mobile-app-specs.md** (15+ pages covering every detail)

**Ready to build!** 🚀
