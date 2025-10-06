# Task Manager

A modern Flutter task management application with null safety support.

## Overview

This is a cross-platform mobile task management application built with Flutter. The app has been completely modernized with null safety support and updated to use the latest Flutter best practices.

## Features

- ✅ **Task Management**: Create, view, edit, and delete tasks with titles, descriptions, and due dates
- ✅ **Priority System**: Three-tier priority classification (High, Medium, Low) with visual indicators
- ✅ **Local Data Persistence**: SQLite database integration for offline task storage and retrieval
- ✅ **Cross-Platform**: Native Android and iOS support with platform-specific UI adaptations
- ✅ **Real-time Updates**: Stream-based architecture using BLoC pattern for reactive UI updates
- ✅ **Modern UI**: Material Design 3 components with custom styling and animations
- ✅ **Task Completion**: Mark tasks as complete/incomplete with visual feedback
- ✅ **Due Date Tracking**: Color-coded due dates (overdue, due soon, normal)

## Technical Stack

- **Framework**: Flutter 3.10+ with Dart 3.0+ (Null Safety)
- **Database**: SQLite with sqflite package
- **Architecture**: BLoC (Business Logic Component) pattern
- **State Management**: StreamBuilder for reactive programming
- **UI**: Material Design 3 components with custom styling
- **Data Layer**: Repository pattern with DAO (Data Access Object) implementation

## Major Updates (v2.0.0)

### Null Safety Migration
- ✅ Updated to Dart 3.0+ with full null safety support
- ✅ All classes and methods now use proper null safety annotations
- ✅ Eliminated all nullable-related runtime errors

### Modern Flutter Practices
- ✅ Updated to Flutter 3.10+ with Material Design 3
- ✅ Proper widget lifecycle management with `late` initialization
- ✅ Modern constructor syntax with `super.key`
- ✅ Updated dependency versions (sqflite 2.3.0, intl 0.19.0, etc.)

### Code Quality Improvements
- ✅ Consistent naming conventions (camelCase, private members with `_`)
- ✅ Proper error handling with try-catch blocks
- ✅ Better separation of concerns and clean architecture
- ✅ Comprehensive input validation and user feedback
- ✅ Memory leak prevention with proper disposal methods

### UI/UX Enhancements
- ✅ Modern splash screen with app branding
- ✅ Improved task cards with better visual hierarchy
- ✅ Enhanced add task form with validation
- ✅ Better empty states and error handling
- ✅ Responsive design with proper spacing and typography
- ✅ Color-coded priority indicators and due date warnings

### Database Improvements
- ✅ Better SQL query structure with proper WHERE clauses
- ✅ Added NOT NULL constraints for required fields
- ✅ Improved database initialization and connection handling
- ✅ Added task update functionality

## Getting Started

### Prerequisites
- Flutter SDK 3.10.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd task-manager
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building for Production

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
└── src/
    ├── bloc/                # Business Logic Components
    │   ├── base_bloc.dart
    │   └── home_bloc.dart
    ├── modals/              # Data models
    │   ├── priority.dart
    │   └── task.dart
    ├── repository/          # Data access layer
    │   ├── core/
    │   ├── dao/
    │   └── repo/
    ├── ui/                  # User interface
    │   ├── cards/
    │   ├── stateful/
    │   └── stateless/
    └── utils/               # Utility classes
        ├── app_utils.dart
        └── routes.dart
```

## Testing

Run unit and widget tests:
```bash
flutter test
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Changelog

### v2.0.0 (Current)
- Complete null safety migration
- Updated to Flutter 3.10+ and Material Design 3
- Improved UI/UX with modern design patterns
- Enhanced error handling and validation
- Better code organization and architecture
- Added task completion functionality
- Improved database operations

### v1.0.0 (Legacy)
- Initial release with basic task management
- SQLite integration
- BLoC pattern implementation
- Basic CRUD operations
