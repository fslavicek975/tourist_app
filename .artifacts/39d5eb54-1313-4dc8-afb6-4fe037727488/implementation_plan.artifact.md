# Implementation Plan - Features & Local Storage

This plan covers the implementation of the Sign Up screen, Sight Details screen, Favorites tab (with Isar), and Profile tab as requested.

## User Review Required

> [!IMPORTANT]
> The prompt mentions "Registers the user via REST API" while the current project uses Firebase for Sign In. I will implement the Sign Up functionality using a new `AuthRestClient` pointing to the provided base URL, but I need to confirm if the backend endpoint for registration is indeed available at `http://144.91.87.48:8080/auth/register` (or similar).

> [!NOTE]
> I will add `isar` for local storage of favorites and rankings as requested.

## Proposed Changes

### Dependencies & Setup
#### [MODIFY] [pubspec.yaml](file:///C:/Users/User/Documents/tourist_app/pubspec.yaml)
- Add `isar`, `isar_flutter_libs`, `path_provider`, `url_launcher`.
- Add `isar_generator` to `dev_dependencies`.

---

### Domain Layer
#### [NEW] [sight_local.dart](file:///C:/Users/User/Documents/tourist_app/lib/domain/model/sight_local.dart)
- Isar schema for storing Sights locally.

#### [MODIFY] [user_repository.dart](file:///C:/Users/User/Documents/tourist_app/lib/domain/repository/user_repository.dart)
- Add `signUp` and `signOut` methods.

#### [NEW] [local_sight_repository.dart](file:///C:/Users/User/Documents/tourist_app/lib/domain/repository/local_sight_repository.dart)
- Interface for local sight operations (favorites, ranking).

#### [NEW] [Use Cases](file:///C:/Users/User/Documents/tourist_app/lib/domain/usecase/)
- `user_sign_up_use_case.dart`
- `toggle_favorite_use_case.dart`
- `get_favorite_sights_use_case.dart`

---

### Data Layer
#### [NEW] [auth_rest_client.dart](file:///C:/Users/User/Documents/tourist_app/lib/data/client/auth_rest_client.dart)
- Retrofit client for REST API registration.

#### [MODIFY] [user_repository_impl.dart](file:///C:/Users/User/Documents/tourist_app/lib/data/repository/user_repository_impl.dart)
- Implement `signUp` using `AuthRestClient`.
- Implement `signOut`.

#### [NEW] [local_sight_repository_impl.dart](file:///C:/Users/User/Documents/tourist_app/lib/data/repository/local_sight_repository_impl.dart)
- Isar-based implementation of local storage.

---

### Presentation Layer
#### [NEW] [sign_up_screen.dart](file:///C:/Users/User/Documents/tourist_app/lib/presentation/auth/screen/sign_up_screen.dart)
- UI for registration with validation.

#### [MODIFY] [authentication_notifier.dart](file:///C:/Users/User/Documents/tourist_app/lib/presentation/auth/notifier/authentication_notifier.dart)
- Add `signUp` and `signOut` methods.

#### [NEW] [sight_details_screen.dart](file:///C:/Users/User/Documents/tourist_app/lib/presentation/sights/screen/sight_details_screen.dart)
- Detailed view with Image, Description, Favorite button, and "Open in Maps".

#### [MODIFY] [favorites_screen.dart](file:///C:/Users/User/Documents/tourist_app/lib/presentation/sights/screen/favorites_screen.dart)
- Display favorited sights from Isar.

#### [MODIFY] [profile_screen.dart](file:///C:/Users/User/Documents/tourist_app/lib/presentation/sights/screen/profile_screen.dart)
- Show logged-in user email and Sign Out button.

#### [MODIFY] [app_router.dart](file:///C:/Users/User/Documents/tourist_app/lib/presentation/core/app_router.dart)
- Register `signUp` and `sightDetails` routes.

---

### Dependency Injection
#### [MODIFY] [di.dart](file:///C:/Users/User/Documents/tourist_app/lib/di.dart)
- Initialize Isar.
- Register new clients, repositories, use cases, and notifiers.

## Verification Plan

### Automated Tests
- Run `flutter test` (if unit tests are implemented).
- Verify Isar schema generation with `dart run build_runner build`.

### Manual Verification
1.  **Sign Up**: Fill fields, click sign up, verify redirection to Home.
2.  **Sight Details**: Open a sight, click Favorite, check if it persists.
3.  **Open in Maps**: Click "Open in Maps" and verify it launches the map app.
4.  **Favorites Tab**: Verify favorited sights appear here; verify "Empty" state if none.
5.  **Profile Tab**: Verify email is displayed; click Sign Out and verify redirection to Sign In.
