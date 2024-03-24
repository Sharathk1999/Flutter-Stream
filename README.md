# Flutter Stream - Early Version

Flutter Stream is an early version of a blog application tailored for Flutter developers. It adheres to Clean Architecture and SOLID design principles, focusing on providing essential functionalities for users to create, manage, and view blog posts.

## Features

### Authentication System

- Basic user signup and login capabilities.
- Integration with Supabase backend for streamlined authentication.
- Session-based authentication state persistence.

### Blog Management

- Simplified blog post creation and uploading functionality.
- Displaying blogs with basic formatting and static reading time estimation.
- Basic blog viewer page for simple, text-based content consumption.

### UI Design

- Simple and intuitive user interfaces for signup, login, and blog management.
- Basic styling for blog cards to enhance readability.

### Database Integration

- Preliminary setup of PostgreSQL tables for storing user profiles and blog posts.
- Minimalistic integration of data sources for basic interaction with the backend.

### State Management

- Basic implementation of the BLoC pattern for managing authentication and UI states.
- Handling of basic loading, failure, and success states in the user interface.

### Dependency Injection

- Introduction of `get_it` for simplified dependency management in the project.
- Basic dependency injection for managing database connections and basic state dependencies.

### Local Storage

- Early integration of Hive for local storage functionality to support offline capabilities.
- Limited functionality for managing user data and blog posts locally.

### Network Connectivity

- Basic implementation of internet connection checks for smoother user experience.
- Limited handling of offline scenarios with simple data synchronization.

## Technologies Used

- Flutter
- Dart
- Clean Architecture
- SOLID Principles
- Supabase
- PostgreSQL
- BLoC Pattern
- `get_it`
- Hive
- Intl Package

## Installation

1. Clone this repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Ensure you have a Supabase backend set up and configured. Update the Supabase configuration in the project as needed.
5. Run the app on your preferred device or simulator using `flutter run`.

## Usage

1. Sign up or log in using your credentials.
2. Create and manage your blog posts.
3. View and read blogs.
4. Enjoy using Flutter Stream!

## Contribution

Contributions are welcome! Feel free to open issues or pull requests to improve the project.

## Screenshots

Here are some screenshots of the application:

- App Work Flow
![App Work Flow](https://github.com/Sharathk1999/Flutter-Stream/blob/main/images/Untitled-2024-03-09-1856.png)

- Login Page
![Login Page](https://github.com/Sharathk1999/Flutter-Stream/blob/main/images/login.png)

- Sign Up Page
![Sign Up Page](https://github.com/Sharathk1999/Flutter-Stream/blob/main/images/signup.png)

- Blog Page
![Blog Page](https://github.com/Sharathk1999/Flutter-Stream/blob/main/images/blog_page.png)

- Blog View Page
![Blog View Page](https://github.com/Sharathk1999/Flutter-Stream/blob/main/images/blog_view_page.png)

- Supabase Table
![Supabase Table](https://github.com/Sharathk1999/Flutter-Stream/blob/main/images/supabase.png)

