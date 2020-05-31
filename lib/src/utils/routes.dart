import 'package:firebasechat/src/ui/stateful/add_task.dart';
import 'package:firebasechat/src/ui/stateful/home_screen.dart';
import 'package:firebasechat/src/ui/stateless/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = "/";
  static const String homeDashBoard = "/HomeDashBoard";
  static const String addTask = "/addTask";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map map = settings.arguments;
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case homeDashBoard:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case addTask:
        return MaterialPageRoute(
            builder: (context) => AddTask(
                  length: map['length'],
                ));

      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
