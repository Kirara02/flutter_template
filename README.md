# Flutter Advanced Base Template

A modern, production-ready Flutter starter template built on **Feature-First Domain-Driven Design (DDD)**. Designed for scalability, type safety, and a great developer experience out of the box.

---

## 🚀 Key Features

| Feature | Detail |
|---|---|
| **Architecture** | Feature-First DDD — clean separation of Data / Domain / Presentation |
| **State Management** | Riverpod with code generation (`riverpod_generator`) |
| **Navigation** | GoRouter with nested shell routing + type-safe route builders |
| **Networking** | Dio with `AuthInterceptor` — auto refresh token & retry on 401 |
| **Localization** | Slang — type-safe i18n with EN & ID support |
| **Theming** | FlexColorScheme + Google Fonts, Light / Dark / System modes |
| **Persistence** | SharedPreferences for token & settings storage |
| **Responsive UI** | Bottom nav (phone) → Navigation Rail (tablet) → Extended Rail (desktop) |
| **Environment** | `.env` configuration via `flutter_dotenv` |
| **Icons** | Font Awesome Flutter v11 |

---

## 🏗️ Project Structure

```text
lib/
├── core/
│   ├── api/                  # Dio client, AuthInterceptor, safeApiCall
│   ├── error/                # AppException hierarchy
│   ├── extensions/           # BuildContext, String, DateTime extensions
│   ├── localization/         # Slang JSON source files + generated strings
│   ├── providers/            # Shared providers (SharedPreferences, Logger)
│   ├── response/             # BaseApiResponse, ApiError models
│   ├── result/               # Result<T> (Success / Failure) sealed class
│   ├── routing/              # GoRouter + shell routes + route guards
│   ├── theme/                # FlexColorScheme, typography, theme provider
│   ├── utils/                # MapSerializable, helpers
│   └── widgets/              # Shared UI components (AppButton, AppTextField…)
└── features/
    ├── auth/
    │   ├── data/             # Datasources, DTOs, repository impl
    │   ├── domain/           # Entities (User), repository interface, use cases
    │   └── presentation/     # AuthNotifier, AuthController, LoginScreen
    ├── home/
    │   └── presentation/     # HomeScreen with profile refresh
    └── settings/
        └── presentation/     # SettingsScreen, MoreScreen, AboutScreen
```

---

## 🛠️ Technical Stack

| Category | Library |
|---|---|
| **State Management** | `flutter_riverpod` · `riverpod_annotation` · `riverpod_generator` |
| **Navigation** | `go_router` · `go_router_builder` |
| **Networking** | `dio` |
| **Localization** | `slang` · `slang_flutter` · `slang_build_runner` |
| **Serialization** | `freezed` · `freezed_annotation` · `json_serializable` |
| **Theming** | `flex_color_scheme` · `google_fonts` |
| **Icons** | `font_awesome_flutter` |
| **Local Storage** | `shared_preferences` |
| **Environment** | `flutter_dotenv` |
| **Logging** | `logger` |

---

## 🏁 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.x (latest stable recommended)
- Dart SDK ≥ 3.x

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/Kirara02/flutter_template.git
cd flutter_template
```

**2. Create `.env` file**

```bash
cp .env.example .env   # then edit BASE_URL
```

```env
BASE_URL=https://your-api.example.com
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Generate localization strings (Slang)**

Slang reads the JSON source files and generates type-safe Dart code.

```bash
dart run slang
```

> Only run this when you add or modify translation keys in `lib/core/localization/en.i18n.json` or `id.i18n.json`.  
> Generated files (`strings.g.dart`, `strings_en.g.dart`, `strings_id.g.dart`) are committed to the repo — you only need to re-run when keys change.

**5. Generate Riverpod / Freezed / GoRouter code**

```bash
dart run build_runner build --delete-conflicting-outputs
```

> **Note**: Run `build_runner` _after_ `dart run slang` so the localization generated files are present and conflict-free.

**6. Run the application**

```bash
flutter run
```

---

## 🔄 Code Generation Quick Reference

| Task | Command |
|---|---|
| Regenerate localization | `dart run slang` |
| Regenerate Riverpod / Freezed / Router | `dart run build_runner build -d` |
| Watch mode (auto-rebuild on save) | `dart run build_runner watch -d` |
| Both at once | `dart run slang && dart run build_runner build -d` |

---

## 🔐 Auth & Token Flow

This template includes a full token lifecycle:

1. **Login** — saves `access_token` + `refresh_token` to SharedPreferences.
2. **AuthInterceptor** — attaches `Bearer <token>` to every request automatically.
3. **Token Expiry** — on 401, interceptor transparently:
   - Calls `POST /api/auth/refresh` with the stored refresh token.
   - Saves the new tokens.
   - Retries the original request (and any queued concurrent requests).
4. **Full Expiry** — if the refresh call also fails, all tokens are cleared and `AuthNotifier` resets the session → GoRouter redirects to Login automatically.

---

## 📱 Responsive Navigation

Adaptive shell navigation based on screen size:

| Screen | Navigation |
|---|---|
| **Phone** | `NavigationBar` (bottom) |
| **Tablet** | `NavigationRail` (side, compact) |
| **Desktop** | `NavigationRail` (side, extended with labels) |

Navigation bar is only shown on top-level routes (`/home`, `/more`). Sub-pages hide it automatically.

---

## 🌐 Localization (Slang)

Translation source files live in `lib/core/localization/`:

```
en.i18n.json   ← English (base)
id.i18n.json   ← Indonesian
```

Usage in Dart:

```dart
// In a widget with BuildContext
context.l10n.login.title
context.l10n.home.greeting(name: user.name)
context.l10n.settings.theme
```

To add a new key:

1. Add the key to `en.i18n.json` and `id.i18n.json`.
2. Run `dart run slang`.
3. Use it via `context.l10n.<section>.<key>`.

---

Built with ❤️ by [Kirara](https://github.com/Kirara02).
