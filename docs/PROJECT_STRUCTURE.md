# 📁 Project Structure

This document explains the purpose of each directory in the **Flutter Premium Base Template**.

## 📂 Root Directory

- `lib/`: All Flutter source code.
- `assets/`: Images, fonts, and other static files.
- `docs/`: Developer documentation (Summary, Standards, etc.).
- `test/`: Unit and widget tests.
- `AGENTS.md`: Agentic AI workflow instructions.
- `pubspec.yaml`: Project dependencies and configuration.

## 📂 lib/ Directory

### 📦 core/ (The Foundation)

Shared infrastructure that rarely changes.

- `auth/`: Authentication logic (SecureStorage, TokenManager, SessionManager).
- `fcm/`: Firebase Cloud Messaging (FCM) service and token management.
- `notification/`: Local notifications setup and background message handlers.
- `services/`: External infrastructure and third-party services.
- `base/`: Base classes like `UseCase` and `Result`.
- `design_system/`: Tokens for colors, spacing, and typography.
- `error/`: Centralized error handling and exceptions.
- `extensions/`: Widget, Context, and Data type extensions.
- `network/`: Dio client, interceptors, and API helpers.
- `router/`: GoRouter setup and route definitions.

### 📦 shared/ (Cross-Feature Components)

Code used by multiple features.

- `i18n/`: Localization JSON files (EN/ID).
- `providers/`: Global Riverpod providers (Firebase, SharedPreferences).
- `widgets/`: Common UI components (AppButton, AppLoader, etc.).

### 📦 features/ (Business Logic)

This is where 90% of the work happens.

- `auth/`: Login, Register, Forgot Password flows.
- `home/`: Main dashboard and feed.
- `settings/`: App settings, profile, and localization toggle.

## 📂 assets/ Directory

- `images/`: PNG/JPG/SVG assets.
- `fonts/`: Custom fonts (if not using Google Fonts).
- `icons/`: App icons and specialized SVGs.

## 🚀 Adding a New Feature

To add a new feature "Profile":

1. Create `lib/features/profile/`.
2. Generate the standard subfolders (`data`, `domain`, `presentation`).
3. Define the domain entities and repository interfaces first.
4. Implement the data layer.
5. Create the Riverpod controllers and UI.
6. Register the new route in `lib/core/router/`.

---

## 🏗️ Technical Architecture Map

```text
lib/
├── core/
│   ├── auth/                 # SecureStorageService, TokenManager, SessionManager
│   ├── fcm/                  # FCMService, AppToken management
│   ├── notification/         # Local Notifications, Background Handlers
│   ├── services/             # External third-party integrations
│   ├── base/                 # UseCase, Result types
│   ├── design_system/        # AppColors, AppSpacing, AppRadius, AppTypography
│   ├── error/                # Custom AppException hierarchy
│   ├── extensions/           # WIDGET, ITERABLE, NUM, CONTEXT extensions
│   ├── gen/                  # Asset/Color generators (flutter_gen)
│   ├── logger/               # Logger configuration
│   ├── network/              # DioClient, AuthInterceptor, safeApiCall
│   ├── response/             # BaseApiResponse, models
│   ├── router/               # GoRouter paths & type-safe Route Builders
│   ├── theme/                # ThemeProvider, FlexColorScheme setup
│   └── utils/                # Mapping and helpers
├── shared/
│   ├── i18n/                 # Slang JSON source (EN/ID) & generated files
│   ├── providers/            # Shared Riverpod providers (SharedPreferences, etc.)
│   └── widgets/              # Standardized UI Components (AppButton, AppTextField, etc.)
└── features/
    ├── auth/
    │   ├── data/             # Datasources, DTOs, Repository implementations
    │   ├── domain/           # Entities, Repository interfaces, Use Cases
    │   └── presentation/     # AuthProvider, AuthController, Screens
    ├── home/
    │   └── presentation/     # HomeScreen and related widgets
    └── settings/
        └── presentation/     # SettingsScreen, MoreScreen, AboutScreen
```
