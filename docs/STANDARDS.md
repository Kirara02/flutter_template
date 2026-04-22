# 📏 Coding Standards & Best Practices

To maintain a high-quality codebase, all developers and AI agents must adhere to these standards.

## 🔡 Naming Conventions

- **Classes**: `PascalCase` (e.g., `LoginRepository`).
- **Variables & Methods**: `camelCase` (e.g., `getUserData`).
- **Files**: `snake_case` (e.g., `auth_repository.dart`).
- **Private members**: Prefix with underscore (e.g., `_isLoggedIn`).

## 🏗️ Folder Structure Standard

Every new feature MUST follow this structure:
```text
features/[feature_name]/
  ├── data/
  │   ├── datasources/
  │   ├── dtos/
  │   └── repositories/
  ├── domain/
  │   ├── entities/
  │   ├── repositories/
  │   └── usecases/
  └── presentation/
      ├── controllers/
      ├── screens/
      └── widgets/
```

## ⚛️ Riverpod Standards

- Always use `@riverpod` or `@Riverpod(keepAlive: true)` annotations.
- Use `riverpod_generator` for all providers.
- Controllers should extend `_$YourControllerName`.
- Avoid using `Ref.watch` inside logic; use it only for dependency injection in constructors or build methods.

## 🎨 UI & Design System

- **Never hardcode values**: Use `context.spacing.md`, `context.radius.lg`, etc.
- **Fluent Extensions**: Use `.padAll()`, `.center`, `.vSpace` instead of wrapping with `Padding`, `Center`, or `SizedBox`.
- **Responsive Design**: Test UI on multiple screen sizes.
- **Theming**: Ensure every widget looks good in both Light and Dark modes.

## 🌐 Localization (I18n)

- All user-facing strings must use `slang`.
- Add keys to `lib/shared/i18n/en.i18n.json` first.
- Access via `context.l10n.translation.key`.

## 🛡️ Errors & Safety

- Use the custom `AppException` hierarchy for errors.
- Wrap API calls in `safeApiCall` (provided in `core/network`).
- Avoid `dynamic` type; always use strong typing or `Object?`.
- Never use `print`; use the global `logger`.

## 🧪 Testing

- Aim for high coverage on **Domain UseCases** and **Data Repositories**.
- Use `mocktail` for dependency mocking.
- Name tests descriptively: `test('should return User when login is successful', ...)`.

---

## 🌐 Localization Usage (Slang)

Translation source files live in `lib/shared/i18n/`.

**Usage in Dart:**
```dart
// In a widget with BuildContext
context.l10n.login.title
context.l10n.home.greeting(name: user.name)
context.l10n.settings.theme
```

---

## 🌓 Theming & Custom Design System

Access tokens anywhere using `BuildContext`:

```dart
// Access Tokens
context.spacing.md    // 16.0
context.radius.borderMd

// Declarative UI (Extensions)
Text("Hello").center.padAll(AppSpacing.md);

// Spacing Utilities
16.vSpace            // Vertical spacing 16.0
12.hSpace            // Horizontal spacing 12.0
```
