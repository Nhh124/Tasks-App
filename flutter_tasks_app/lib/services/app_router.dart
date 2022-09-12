import 'package:flutter/material.dart';
import '/presentation/screens/recycle_bin.dart';
import '/presentation/screens/tasks_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBinSCreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RecycleBinSCreen(),
        );
      case TasksScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const TasksScreen(),
        );
      default:
    }
    return null;
  }
}
