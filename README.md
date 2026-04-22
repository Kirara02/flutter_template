# 🚀 Flutter Premium Base Template

A modern, high-fidelity, and production-ready Flutter starter template built on **Feature-First Domain-Driven Design (DDD)**. Designed for maximum developer productivity and a premium experience.

---

## 💎 Key Features

| Feature                | Detail                                                                 |
| ---------------------- | ---------------------------------------------------------------------- |
| **Clean Architecture** | Feature-First DDD — strict separation of Data / Domain / Presentation. |
| **Design System**      | Centralized design tokens (Colors, Spacing, Radius, Typography).       |
| **State Management**   | Riverpod 3.x with advanced code generation.                            |
| **Navigation**         | GoRouter with type-safe route builders.                                |
| **I18n / L10n**        | Slang — compile-time safe translations.                                |
| **Premium Theming**    | FlexColorScheme v8 + Google Fonts support.                             |

---

## 📖 Documentation

For detailed guides and standards, please refer to:

- [🤖 Agentic AI Workflow](AGENTS.md) — How to use AI specialists.
- [📝 Development Summary](docs/DEVELOPMENT.md) — Tech stack & Code Generation.
- [📏 Coding Standards](docs/STANDARDS.md) — conventions & usage examples.
- [📂 Project Structure](docs/PROJECT_STRUCTURE.md) — Folder breakdown & architecture map.

---

## 📂 Artifact Explorer

Access the living documentation and execution state through these system artifacts:

- [📝 Requirements](docs/requirements.md) — Feature specs and user stories.
- [📐 Implementation Plan](docs/implementation_plan.md) — Architectural design and logic flow.
- [✅ Task Roadmap](task.md) — Real-time progress tracking.
- [🚀 Walkthrough](docs/walkthrough.md) — Final implementation summary.

---

## 🏁 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.x
- Dart SDK ≥ 3.x

### Installation

1. **Clone & Setup Environment**
   ```bash
   git clone https://github.com/Kirara02/flutter_template.git
   cp .env.example .env
   ```
2. **Install & Generate**
   ```bash
   flutter pub get
   dart run slang
   dart run build_runner build -d
   ```

---

## 🤖 Agentic AI Workflow

This project supports specialized AI agents. Type `/` in the chat to see available workflows:

- `/agent` : Smart Dispatcher (Coordination)
- `/pm` : Product Manager (Requirements)
- `/arch` : App Architect (System Design)
- `/ui` : UI Specialist (Presentation)
- `/dev` : Feature Developer (Logic)
- `/qa` : QA Engineer (Validation)

Refer to [AGENTS.md](AGENTS.md) for the collaboration protocol.

---

Built with 💎 by **Kirara Bernstein** (2026).
