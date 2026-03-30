# Flutter Advanced Base Template

A modern, robust, and production-ready Flutter base template implementing **Feature-First Domain-Driven Design (DDD)**. This project is built with scalability, testability, and developer experience in mind.

## 🚀 Key Features

- **Architecture**: Feature-First DDD for clear separation of concerns.
- **State Management**: [Riverpod](https://riverpod.dev) with code generation for a safe and robust state.
- **Routing**: [GoRouter](https://pub.dev/packages/go_router) with nested shell routing.
- **Network**: [Dio](https://pub.dev/packages/dio) with centralized client, interceptors, and safe API call handling.
- **Responsive UI**: Built-in `BuildContext` extensions for `isPhone`, `isTablet`, and `isDesktop` layout detection.
- **Theming**: [FlexColorScheme](https://docs.flexcolorscheme.com/) for beautiful, customizable Light/Dark themes.
- **Internationalization**: [Slang](https://pub.dev/packages/slang) for type-safe translations (EN, ID support).
- **Persistence**: Token and settings persistence using `SharedPreferences`.
- **Environment**: Support for `.env` configuration.

## 🏗️ Architecture (Feature-First DDD)

The project follows a modular structure where each feature is self-contained:

```text
lib/
├── core/                # Global backbone (API, Theme, Routing, etc.)
│   ├── api/             # Dio Client & Interceptors
│   ├── localization/    # Slang translations
│   ├── routing/         # GoRouter configuration
│   └── theme/           # FlexColorScheme setup
└── features/            # Feature modules
    └── auth/
        ├── data/        # DataSources, Models, Repositories Impl
        ├── domain/      # Entities, Repositories Interface, UseCases
        └── presentation/# Providers (State), Screens, Widgets
```

## 🛠️ Technical Stack

| Category             | Library                                  |
| :------------------- | :--------------------------------------- |
| **State Management** | `flutter_riverpod`, `riverpod_generator` |
| **Navigation**       | `go_router`, `go_router_builder`         |
| **Networking**       | `dio`                                    |
| **Localization**     | `slang`, `slang_flutter`                 |
| **Styling**          | `flex_color_scheme`, `google_fonts`      |
| **Serialization**    | `freezed`, `json_serializable`           |
| **Local Storage**    | `shared_preferences`                     |

## 🏁 Getting Started

### Prerequisites

- Flutter SDK (latest version recommended)
- Dart SDK

### Installation

1.  **Clone the repository**:

    ```bash
    git clone <repository-url>
    cd kirara_template
    ```

2.  **Environment Setup**:
    Create a `.env` file in the root directory (refer to `.env.example` if available):

    ```env
    BASE_URL=https://api.example.com
    ```

3.  **Install dependencies**:

    ```bash
    flutter pub get
    ```

4.  **Generate code**:

    ```bash
    dart run build_runner build -d
    ```

5.  **Run the application**:
    ```bash
    flutter run
    ```

## 📱 Responsiveness

We use custom `BuildContext` extensions for easy responsive layout switching in `app_shell.dart`:

- **Phone**: Integrated `BottomNavigationBar`.
- **Tablet/Desktop**: Smart `NavigationRail` with `extended` mode for Desktop.

---

Built with ❤️ by Antigravity.
