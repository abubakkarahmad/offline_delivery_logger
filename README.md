# offline_delivery_logger

A Flutter project for logging deliveries offline.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

## Architecture & Design Decisions

- **Framework:** Flutter for cross-platform development.
- **Database:** Sqflite for local persistent storage.
- **Structure:** Follows a simple MVC-like architecture:
    - **Model:** Handles data structures and database interactions
    - **View:** UI screens
    - **Controller:** Business logic connecting model and view
- **Design Choices:**
    - Focused on core functionality first.
    - Modular structure to allow easy future feature additions.

---

## Time Spent & Trade-offs

- **Total Time:** Approximately **15 hours over 2 days**.
- **Challenges:** Used **Sqflite** for the first time and referred to online resources for help.
- **Trade-offs:** Prioritized core functionality; some additional features were simplified or skipped due to time constraints.
