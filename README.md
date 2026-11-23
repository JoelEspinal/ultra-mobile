# 📱 Ultra Mobile — Flutter To-Do (Clean Architecture demo)

A Flutter to-do app built as a technical challenge. It shows Clean Architecture
with immutable models, Cubit state management, functional error handling and
offline-first persistence.

## ✨ Features
- Fetches to-dos from the [DummyJSON](https://dummyjson.com/docs/todos) API with
  pagination (`limit` / `skip`)
- Caches them locally with Hive, so the list works offline after the first load
- Create, read, update and delete to-dos, with priority and due date
- Attach an image to a to-do from the camera or gallery (`image_picker`)

## 🏗️ Architecture
```text
lib/src/
├── domain/        # Entities, repository contracts, use cases, failures (no Flutter imports)
├── data/          # Dio API client, Hive data source and models, repository implementations
└── presentation/  # Pages + Cubits (MVVM)
```

- **Clean Architecture:** strict separation between domain, data and presentation
- **MVVM:** each screen has a Cubit acting as its ViewModel
- **Repository pattern:** the domain depends on abstractions, not on Dio or Hive
- **Adapter mapping:** `fromEntity` / `toEntity` between Hive models and domain entities
- **Functional errors:** repositories return `Either<Failure, T>` (dartz)
- **Immutability:** entities and models generated with freezed

## 🛠️ Tech
Flutter · Dart · flutter_bloc (Cubit) · Provider (DI) · Dio · Hive CE ·
freezed · json_serializable · dartz · image_picker · intl

## ▶️ Run it
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Camera and gallery permissions must be set in `Info.plist` (iOS) and
`AndroidManifest.xml` (Android) to attach images.
