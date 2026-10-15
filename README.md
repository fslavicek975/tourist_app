# 🌍 Tourist App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Riverpod](https://img.shields.io/badge/Riverpod-00599C?style=for-the-badge&logo=flutter&logoColor=white)](https://riverpod.dev)
[![Isar DB](https://img.shields.io/badge/Isar%20DB-42A5F5?style=for-the-badge&logo=database&logoColor=white)](https://isar.dev)

A modern, feature-packed Flutter application designed to help users discover tourist attractions, explore detailed sight descriptions, view ratings, and save favorite sights locally for offline access. Built using **Clean Architecture**, **Riverpod**, **Retrofit**, **Firebase Auth**, and **Isar Community Database**.

---

## 📱 Features

- **🔐 User Authentication**: Secure email and password registration, login, and sign-out powered by Firebase Authentication.
- **🗺️ Sight Exploration**: Discover popular tourist destinations, complete with descriptions, location coordinates, rating stars, and high-resolution images retrieved via REST API.
- **⭐ Offline Favorites**: Save your favorite destinations locally with Isar NoSQL database for fast, offline access anytime.
- **✨ Animated & Responsive UI**: Beautiful user interface featuring custom **Montserrat** typography, Lottie animations, state-driven UI screens (loading, empty, error, success), and custom themes.
- **👤 User Profile**: Personal account management screen showing active user credentials and easy sign-out.

---

## 🏗️ Architecture

The project adheres strictly to **Clean Architecture** principles to promote modularity, testability, and separation of concerns:

```
lib/
├── data/                  # Data Layer (API clients, Isar DB, Repository implementations)
│   ├── client/            # Retrofit REST Client & Firebase Auth Client
│   └── repository/        # Concrete Repository Implementations
├── domain/                # Domain Layer (Business Logic)
│   ├── model/             # Data Models (Sight, SightLocal, Result)
│   ├── repository/        # Abstract Repository Interfaces
│   └── usecase/           # Business Use Cases (Auth, Sights, Favorites)
├── presentation/          # Presentation Layer (UI & State Management)
│   ├── auth/              # Authentication Screens (Splash, Sign In, Sign Up)
│   ├── core/              # Theme, Extensions, Custom Widgets & App Router
│   └── sights/            # Sight Lists, Favorites, Profile, Details Screens
├── di.dart                # Dependency Injection (Riverpod Providers)
└── main.dart              # Application Entry Point
```

---

## 🛠️ Tech Stack & Tools

- **Framework**: [Flutter](https://flutter.dev) (Dart SDK `^3.9.2`)
- **State Management & DI**: [Flutter Riverpod](https://riverpod.dev) (`^2.6.1`)
- **Network Layer**: [Retrofit](https://pub.dev/packages/retrofit) (`^4.10.0`) & [Dio](https://pub.dev/packages/dio) (`^5.7.0`)
- **Authentication**: [Firebase Auth](https://firebase.google.com/docs/auth) (`6.1.3`) & [Firebase Core](https://firebase.google.com/docs/core) (`4.3.0`)
- **Local Persistence**: [Isar Community Database](https://isar.dev) (`^3.3.2`)
- **UI Components & Utilities**:
  - [Lottie](https://pub.dev/packages/lottie) (`^3.3.2`) for vector animations
  - Montserrat Google Font family
  - Custom UI Components (`CustomTextField`, `CustomActionButton`, `RatingStars`, `SightCard`)
- **Code Generation**: `build_runner`, `retrofit_generator`, `json_serializable`, `isar_community_generator`

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version `>= 3.9.2`)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code with Flutter extensions
- An active Firebase Project (for Authentication)

---

### Installation & Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/tourist_app.git
   cd tourist_app
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run Code Generation**:
   Since the project uses Retrofit, JSON Serializable, and Isar models, run `build_runner` to generate required files (`.g.dart` files):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Firebase Configuration**:
   - Add your `google-services.json` file to the `android/app/` directory.
   - Add your `GoogleService-Info.plist` file to the `ios/Runner/` directory (for iOS support).
   - Ensure Firebase Authentication (Email/Password) is enabled in your Firebase Console.

5. **Run the Application**:
   ```bash
   flutter run
   ```

---

## 🧪 Code Generation Commands

If you make modifications to data models, REST endpoints, or Isar database schemas, execute:

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
dart run build_runner watch --delete-conflicting-outputs
```

---

## 📂 Assets

- `assets/fonts/`: Montserrat font family (Light, Regular, Medium, SemiBold, Bold, Black).
- `assets/images/`: Custom placeholders, error illustrations, background images.
- `assets/animations/`: Lottie animations for loading states and empty results.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
