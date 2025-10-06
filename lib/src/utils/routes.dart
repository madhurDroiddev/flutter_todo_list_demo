import 'package:task_manager/src/ui/stateful/add_task.dart';
import 'package:task_manager/src/ui/stateful/home_screen.dart';
import 'package:task_manager/src/ui/stateless/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = "/";
  static const String homeDashBoard = "/HomeDashBoard";
  static const String addTask = "/addTask";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic>? arguments = 
        settings.arguments as Map<String, dynamic>?;
        
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case homeDashBoard:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
        
      case addTask:
        final int length = arguments?['length'] ?? 0;
        return MaterialPageRoute(
          builder: (context) => AddTask(length: length),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}
