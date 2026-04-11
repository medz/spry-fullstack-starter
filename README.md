# Spry Fullstack Starter

A deliberately opinionated and minimal full-stack starter built with `Spry`, `Flutter`, and `unrouter`.

The template currently includes a small user management example:

- `GET /users`
- `GET /users/:id`
- `POST /users`
- Three Flutter pages: list, details, and create

## Stack

- Backend: `spry`
- Frontend: `flutter`
- Routing: `unrouter`
- API calls: Spry generated client

## Structure

```text
lib/app/
  api.dart
  app.dart
  router.dart
  pages/
    home.dart
    details.dart
    create.dart

routes/
  users/
    index.get.dart
    index.post.dart
    [id].get.dart

middleware/
  01_cors.dart
```

## Philosophy

This starter is intentionally simple:

- one global `api`
- one global `router`
- pages call the generated client directly
- list and details use `defineDataLoader`
- create calls `POST /users` directly

The goal is not to demonstrate a layered architecture. The goal is to give you a template you can start modifying immediately.

## Getting Started

1. Create a project from this template
2. Install dependencies
3. Generate the Flutter platforms you actually need
4. Start the Spry backend
5. Run the Flutter app

```bash
flutter pub get
dart run spry build
```

## Generate Flutter Platforms

This template repository intentionally ignores the following platform directories:

- `android/`
- `ios/`
- `linux/`
- `macos/`
- `web/`
- `windows/`

That means:

- those directories may exist in your local workspace
- but they are not treated as fixed template content
- template users should generate or regenerate the platforms they need with `flutter create`

For example:

```bash
flutter create . --platforms=macos,ios,android,web
```

Or only generate the targets you need:

```bash
flutter create . --platforms=macos
flutter create . --platforms=web
```

## Local Development

Start Spry first:

```bash
dart run spry serve
```

Default addresses:

- API: `http://127.0.0.1:4000`
- OpenAPI UI: `http://127.0.0.1:4000/docs`

Then run Flutter:

```bash
flutter run
```

The frontend currently sends requests to:

```text
http://127.0.0.1:4000
```

If you change the backend address, update both:

- `lib/app/api.dart`
- `spry.config.dart`

## After Changing the API

If you change any route under `routes/`, regenerate the Spry runtime and client:

```bash
dart run spry build
```

This updates local generated artifacts:

- `.spry/`
- `lib/src/generated/api/`
- `public/openapi.json`

These generated files are already ignored by the template and do not need manual maintenance.

## Common Commands

```bash
flutter pub get
dart run spry build
dart run spry serve
flutter analyze
flutter test
flutter run
```
