# Flutter Web Project Setup

## Prerequisites Installation

If Flutter is not installed, Claude Code will need to install it first.

### Quick Flutter Installation
```bash
# Install Flutter SDK
cd ~
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:$HOME/flutter/bin"

# Add to shell profile for persistence
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc

# Verify installation
flutter --version

# Enable web support
flutter config --enable-web

# Install dependencies
flutter doctor
```

### Project Initialization
```bash
# Create Flutter project (web-optimized)
cd DAM-Africa
flutter create --platforms=web,android,ios fleet-web
cd fleet-web

# Add dependencies
flutter pub add riverpod flutter_riverpod
flutter pub add http
flutter pub add socket_io_client
flutter pub add google_maps_flutter_web
flutter pub add flutter_secure_storage
flutter pub add cached_network_image
flutter pub add shared_preferences

# Dev dependencies
flutter pub add --dev flutter_test
```

---

## Project Structure Created

```
fleet-web/
├── lib/
│   └── main.dart (default, will be replaced)
├── web/
│   ├── index.html
│   └── manifest.json
├── android/ (future mobile support)
├── ios/ (future mobile support)
├── test/
└── pubspec.yaml
```

---

## First Build Test
```bash
# Test web build
flutter run -d chrome

# Or build for deployment
flutter build web --release
```

---

Ready for Phase 1 implementation! ✅
