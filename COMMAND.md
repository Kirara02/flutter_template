# Role

Bertindaklah sebagai Senior Flutter Architect & Developer.

# Konteks

Saya baru saja membuat empty Flutter project (flutter create my_app). Saya membutuhkan scaffolding base template yang production-ready, scalable, dan maintainable.

# Arsitektur

Gunakan pendekatan **Domain-Driven Design (DDD)** yang dipadukan dengan **Clean Architecture**. Pisahkan layer secara ketat:

1. **Domain Layer**: Entities, Repository Interfaces, Use Cases (Pure Dart, no Flutter dependencies).
2. **Data Layer**: Repository Implementations, API Services, DTOs/Models.
3. **Presentation Layer**: UI Widgets, Screens, State Management (Providers), Routing.

# Tech Stack & Packages (Wajib & Rekomendasi)

Gunakan versi stabil terbaru yang kompatibel dengan Flutter terbaru (Dart 3+).

1. **State Management**: `flutter_riverpod` + `riverpod_annotation` + `riverpod_generator`.
2. **Routing**: `go_router` + `go_router_builder`.
3. **Networking**: `dio` (untuk network client).
4. **Code Generation**: `build_runner` + `freezed` + `freezed_annotation` + `json_serializable`.
5. **Assets Generation**: `flutter_gen` (untuk generate assets: images, fonts, colors, strings).
6. **Localization**: `flutter_localizations` + `intl` + `arb` files (atau rekomendasi package lain seperti `slang`).
7. **Logging**: `logger`.
8. **Dependency Injection**: Menggunakan Riverpod ProviderContainer sebagai DI.
9. **Linting**: `very_good_analysis` atau `flutter_lints` (configure strict rules).

> **Catatan Penting:**
>
> 1. **Error Handling (App Level)**: Jangan gunakan `dartz`. Buat **Sealed Class `Result<T>`** (Dart 3 feature) untuk return type UseCase & Repository. Ini harus memiliki state `Success(data)` dan `Failure(exception)`.
> 2. **Base API Response (Network Level)**: Wajib membuat struktur **`BaseApiResponse<T>`** (Freezed) yang konsisten untuk menstandardisasi JSON response dari backend (status, message, data, error code, dll).
> 3. **Distinction**: Jelaskan perbedaan penggunaan `Result<T>` (flow aplikasi) vs `BaseApiResponse<T>` (struktur JSON).
> 4. **Theming**: Wajib support **Dark/Light Mode** dengan menggunakan `ThemeMode` dan `ThemeData` yang terpisah. Gunakan `flutter_gen` untuk generate color palette.
> 5. **Localization**: Wajib support multi-language (minimal EN & ID) menggunakan `.arb` files atau package modern seperti `slang`.
> 6. **Responsive Navigation**: Wajib implementasi **Shell Screen** dengan navigasi yang adaptif:
>    - **Mobile**: Bottom Navigation Bar (NavBar)
>    - **Tablet/Desktop**: Navigation Rail (NavRail)
>    - Gunakan `LayoutBuilder` atau `MediaQuery` untuk breakpoint detection.
> 7. **Extensions**: Wajib membuat folder **`extensions/`** yang berisi extension methods untuk:
>    - **BuildContext**: theme, localization, navigation, screen size, keyboard, dll.
>    - **String**: validate email, phone, empty check, capitalize, dll.
>    - **DateTime**: format, time ago, dll.
>    - **Int/Double**: format currency, percentage, dll.
>    - **Widget**: padding, margin, gesture, dll.
> 8. **Rekomendasi**: Jika ada package lain yang menurutmu krusial untuk standar industri (contoh: local storage `hive`/`isar`, secure storage `flutter_secure_storage`, environment config `flutter_dotenv`, atau testing utilities `mocktail`), **silakan tambahkan** ke dalam `pubspec.yaml` dan jelaskan alasannya.

# 📁 Folder Structure Requirements (WAJIB DIKUTI)

Struktur folder harus mengikuti pola berikut secara ketat:

```
lib/
├── core/ # Core utilities & shared components
│ ├── api/ # API configuration
│ │ ├── dio_client.dart # Dio instance configuration
│ │ ├── api_constants.dart # API endpoints & constants
│ │ └── interceptors/ # Dio interceptors
│ │ ├── auth_interceptor.dart
│ │ ├── logging_interceptor.dart
│ │ └── error_interceptor.dart
│ ├── error/ # Error handling
│ │ ├── failures.dart # Failure sealed class
│ │ ├── exceptions.dart # Custom exceptions
│ │ └── error_handler.dart # Error mapping logic
│ ├── result/ # Result pattern (Sealed Class)
│ │ └── result.dart # Result<T> sealed class
│ ├── response/ # API Response wrapper
│ │ └── base_api_response.dart # BaseApiResponse<T>
│ ├── extensions/ # Extension methods
│ │ ├── build_context_extensions.dart
│ │ ├── string_extensions.dart
│ │ ├── date_time_extensions.dart
│ │ ├── num_extensions.dart
│ │ ├── widget_extensions.dart
│ │ └── extensions.dart # Barrel export
│ ├── theme/ # Theme configuration
│ │ ├── app_theme.dart # ThemeData setup
│ │ ├── app_colors.dart # Color palette
│ │ ├── app_text_styles.dart # Text styles
│ │ └── theme_provider.dart # Riverpod theme provider
│ ├── localization/ # Localization setup
│ │ ├── app_localizations.dart
│ │ ├── locale_provider.dart # Riverpod locale provider
│ │ └── l10n/ # .arb files
│ │ ├── app_en.arb
│ │ └── app_id.arb
│ ├── routing/ # Routing configuration
│ │ ├── app_router.dart # GoRouter setup
│ │ ├── app_routes.dart # Route constants
│ │ └── route_guard.dart # Auth guard logic
│ ├── utils/ # General utilities
│ │ ├── logger.dart # Logger setup
│ │ ├── validators.dart # Input validators
│ │ └── constants.dart # App constants
│ └── widgets/ # Reusable widgets
│ ├── common/ # Common widgets
│ │ ├── app_button.dart
│ │ ├── app_text_field.dart
│ │ ├── app_loading.dart
│ │ └── app_error.dart
│ └── shell/ # Shell navigation
│ ├── app_shell.dart # Responsive shell screen
│ ├── nav_bar.dart # Bottom navigation (mobile)
│ └── nav_rail.dart # Side navigation (tablet/desktop)
│
├── features/ # Feature modules
│ ├── auth/ # Authentication feature
│ │ ├── domain/ # Domain layer
│ │ │ ├── entities/ # Business entities
│ │ │ │ └── user.dart
│ │ │ ├── repositories/ # Repository interfaces
│ │ │ │ └── auth_repository.dart
│ │ │ └── usecases/ # Business logic
│ │ │ ├── login_usecase.dart
│ │ │ ├── logout_usecase.dart
│ │ │ └── get_current_user_usecase.dart
│ │ ├── data/ # Data layer
│ │ │ ├── datasources/ # Data sources
│ │ │ │ ├── auth_remote_datasource.dart
│ │ │ │ └── auth_local_datasource.dart
│ │ │ ├── models/ # DTOs & Models
│ │ │ │ ├── login_request.dart
│ │ │ │ ├── login_response.dart
│ │ │ │ └── user_model.dart
│ │ │ └── repositories/ # Repository implementations
│ │ │ └── auth_repository_impl.dart
│ │ └── presentation/ # Presentation layer
│ │ ├── providers/ # Riverpod providers
│ │ │ ├── auth_provider.dart
│ │ │ └── auth_state.dart
│ │ ├── screens/ # Screens/Pages
│ │ │ ├── login_screen.dart
│ │ │ └── register_screen.dart
│ │ └── widgets/ # Feature-specific widgets
│ │ ├── login_form.dart
│ │ └── login_button.dart
│ │
│ ├── home/ # Home feature (same structure as auth)
│ │ ├── domain/
│ │ ├── data/
│ │ └── presentation/
│ │
│ └── profile/ # Profile feature (same structure as auth)
│ ├── domain/
│ ├── data/
│ └── presentation/
│
├── dependency_injection.dart # Riverpod DI setup
└── main.dart # Entry point
```

# 📝 Import Convention Examples (WAJIB DIKUTI)

```dart
// ✅ GOOD: Package import untuk cross-module
import 'package:my_app/core/result/result.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';

// ✅ GOOD: Relative import untuk file dalam folder sama
import 'auth_provider.dart';
import 'auth_state.dart';

// ✅ GOOD: Relative import untuk subfolder langsung
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';

// ❌ BAD: Lebih dari 2 level relative import
import '../../../core/result/result.dart';  // DON'T DO THIS!
import '../../../../features/auth/...';     // DON'T DO THIS!

# Deliverables (Output yang Diharapkan)

Mohon berikan output dalam urutan berikut:

1. **`pubspec.yaml`**: Daftar dependencies dan dev_dependencies yang lengkap (termasuk rekomendasi tambahanmu).
2. **`flutter_gen.yaml`**: Konfigurasi `flutter_gen` untuk generate assets, colors, fonts, dan strings.
3. **Folder Structure**: Tree struktur direktori `lib/` dan `assets/` yang mencerminkan arsitektur DDD (sesuai requirements di atas).
4. **Core Setup**:
   - **Sealed Result Class**: Implementasi `Result<T>` menggunakan Dart 3 sealed class/pattern matching.
   - **Base API Response**: Implementasi `BaseApiResponse<T>` menggunakan Freezed.
   - **Dio Configuration**: Interceptors, logger, base url, dan logic mapping dari `BaseApiResponse` ke `Result<T>`.
   - **GoRouter Configuration**: Shell route, redirect logic (auth guard), error page, localization support, dan **nested routing untuk Shell Screen**.
   - **Riverpod Configuration**: Provider observer untuk logging state changes, theme provider, locale provider, dan navigation provider.
   - **Theme Configuration**: Light & Dark theme dengan `ThemeData` terpisah, menggunakan colors dari `flutter_gen`.
   - **Localization Setup**: Konfigurasi `.arb` files atau `slang` untuk EN & ID, beserta cara mengaksesnya di UI.
   - **Shell Screen Implementation**: Widget shell yang responsive dengan NavBar (mobile) dan NavRail (tablet/desktop).
   - **Extensions Library**: Kumpulan extension methods yang reusable dan terdokumentasi.
5. **Contoh Implementasi (Feature: Login + Home Shell)**:
   - **Login Flow**: UI (Riverpod + i18n + Theme + Extensions) -> UseCase (Return `Result<User>`) -> Repository -> DataSource (Return `BaseApiResponse`).
   - **Home Shell**: Setelah login, tampilkan Shell Screen dengan minimal 2 tab (misal: Home & Profile).
   - Sertakan `Freezed` model untuk Request/Response DTO.
   - Tunjukkan bagaimana `Result<T>` di-handle di UI (misal: ketika Success navigasi, ketika Failure show snackbar).
   - Gunakan localized strings untuk semua text di UI.
   - Demonstrasikan toggle Dark/Light mode.
   - Demonstrasikan responsive navigation (ubah ukuran layar untuk melihat transisi NavBar <-> NavRail).
   - **Gunakan extensions** untuk semua operasi yang relevan (contoh: `context.l10n`, `context.theme`, `email.validate()`, `dateTime.format()`, dll).
6. **`main.dart`**: Entry point yang rapi dengan initialization providers, theme, dan localization.
7. **Penjelasan Rekomendasi**: Bagian khusus yang menjelaskan mengapa kamu menambahkan package tambahan (jika ada).

# Constraints

- Gunakan Null Safety & Dart 3 features (sealed classes, pattern matching, records, etc).
- Pastikan kode mengikuti best practice (immutable state, pure functions di domain layer).
- Berikan komentar singkat pada bagian krusial.
- Jangan gunakan setState, gunakan Riverpod secara konsisten.
- `BaseApiResponse` harus reusable untuk semua endpoint.
- `Result<T>` harus menjadi standar return type untuk semua UseCase.
- Semua text di UI harus menggunakan localization (hardcoded text dilarang).
- Theme harus support system default (auto detect dark/light) dengan manual override option.
- Assets (images, fonts, colors) harus di-generate menggunakan `flutter_gen`.
- **Shell Screen harus responsive dengan breakpoint yang jelas (mobile < 600px, tablet >= 600px, desktop >= 1200px).**
- **Navigation state harus persistent saat rotate device atau resize window.**
- **Extensions harus terorganisir per tipe dan tidak boleh membuat konflik naming.**
- **Gunakan extensions untuk mengurangi boilerplate code di seluruh proyek.**
- **Folder structure HARUS mengikuti pola yang telah ditentukan di atas.**

Mulailah sekarang.
```
