# 📖 Development Summary

This document provides a high-level overview of the development process and architectural choices for the **Flutter Premium Base Template**.

## 🏗️ Architecture: Feature-First DDD

We follow a **Feature-First Domain-Driven Design (DDD)** approach. Instead of grouping files by type (e.g., all controllers in one folder), we group them by functional feature.

### Layer Responsibilities

1. **Data Layer**:
   - `datasources/`: Remote (API) and Local (DB/Cache) data fetching.
   - `dtos/`: Data Transfer Objects for JSON serialization.
   - `repositories/`: Concrete implementations of domain repositories using data sources.
   - `mappers/`: Converting DTOs to Domain Entities and vice versa.

2. **Domain Layer**:
   - `entities/`: Pure Dart business models (usually `Freezed`).
   - `repositories/`: Abstract interface definitions.
   - `usecases/`: Single-responsibility business logic classes.

3. **Presentation Layer**:
   - `controllers/`: Riverpod StateNotifier/AsyncNotifier to manage UI state.
   - `screens/`: High-level page widgets.
   - `widgets/`: Feature-specific UI components.

## 🛠️ Technical Stack

- **State Management**: [Riverpod 3.x](https://riverpod.dev) with custom generators.
- **Routing**: [GoRouter](https://pub.dev/packages/go_router) for type-safe, deep-linkable navigation.
- **Networking**: [Dio](https://pub.dev/packages/dio) with interceptors for auth and logging.
- **Localization**: [Slang](https://pub.dev/packages/slang) for compile-time safe translations.
- **Theming**: [FlexColorScheme](https://pub.dev/packages/flex_color_scheme) for premium look and feel.
- **Serialization**: [Freezed](https://pub.dev/packages/freezed) and [JsonSerializable](https://pub.dev/packages/json_serializable).

## 🔄 Development Flow

1. **Requirement Analysis**: Defined by `/pm`.
2. **Feature Scaffolding**: Folder structure created by `/arch`.
3. **Database/API Contract**: DTOs and DataSources implemented in the Data layer.
4. **Business Logic**: Entities and Repositories in the Domain layer.
5. **UI & State**: Screens and Controllers in the Presentation layer.
6. **Code Generation**: Run `dart run build_runner build` frequently.

---

## 🛠️ Technical Ecosystem

| Category         | Recommended Libraries                                             |
| ---------------- | ----------------------------------------------------------------- |
| **State**        | `flutter_riverpod` · `riverpod_annotation` · `riverpod_generator` |
| **Routing**      | `go_router` · `go_router_builder`                                 |
| **Networking**   | `dio`                                                             |
| **Storage**      | `flutter_secure_storage` · `shared_preferences`                   |
| **Localization** | `slang` · `slang_flutter`                                         |
| **Theming**      | `flex_color_scheme` · `google_fonts`                              |
| **Persistence**  | `freezed` · `json_serializable`                                   |

---

## 🔄 Code Generation Quick Reference

| Task         | Command                                                    |
| ------------ | ---------------------------------------------------------- |
| Refresh All  | `dart run slang && dart run build_runner build -d`         |
| Watch Mode   | `dart run build_runner watch --delete-conflicting-outputs` |
| Build Once   | `dart run build_runner build --delete-conflicting-outputs` |
| Localization | `dart run slang`                                           |
