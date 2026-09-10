# Outme Smart 📱

Outme Smart is a robust Flutter application developed for a machine test. It is built using a modern **MVVM / GetX architecture** designed to provide a highly scalable, maintainable, and reactive user experience.

## ✨ Features

- **OTP Authentication**: Seamless user login and verification with OTP via `AuthController`.
- **Token Management**: Secure storage of `accessToken` and `refreshToken` using `SharedPreferences`.
- **Dynamic Homepage**: Features trending products, nearby stores, and categories using real-time API integrations.
- **Store Discovery**: Explore stores, search by categories, and find local shops nearby.
- **Smart Cart System**: Comprehensive multi-store cart management (add, update, remove items, and view price breakups).
- **Persistent Bottom Navigation**: Modular and responsive bottom navigation mapping directly to Home, Shops, Cart, and Profile screens.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management, Routing, & DI**: [GetX](https://pub.dev/packages/get)
- **Networking**: [http](https://pub.dev/packages/http)
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)

## 📁 Architecture & Folder Structure

The app strictly follows a clean architecture model focusing on separation of concerns.

```
lib/
├── controllers/          # GetX Controllers managing the state & business logic (Auth, Cart, Home)
├── core/
│   ├── constants/        # App-wide constants (ApiConstants, AppColors, AppRoutes)
│   ├── network/          # API Client managing HTTP requests with Authorization headers
│   └── services/         # Core services like StorageService
├── data/
│   ├── models/           # Data models mapping JSON responses (User, Cart, Store, Offer, etc.)
│   └── repositories/     # Abstraction layer over the network client for cleaner Controller code
├── routes/               # Centralized route definitions and page bindings
└── views/                # UI Screens (Auth, Home, Cart, Category, Onboarding, Profile)
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.11.3`
- Dart SDK

### Installation

1. Clone the repository to your local machine.
2. Run `flutter pub get` to install all required dependencies.
3. If running on iOS, navigate to the `ios` directory and run `pod install`.
4. Run the app using `flutter run` on your preferred emulator or physical device.

## 🔗 API Integration Overview

The app's networking layer is centralized in `lib/core/network/api_client.dart`. It includes automatic token injection for authenticated requests and supports standard `GET`, `POST`, `PATCH`, and `DELETE` requests.

API Endpoints are mapped directly into `lib/core/constants/api_constants.dart` for scalability.

---
*Developed as a Flutter Machine Test*
