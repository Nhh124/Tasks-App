import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/presentation/screens/tabs_screen.dart';
import '/presentation/screens/recycle_bin.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBinSCreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RecycleBinSCreen(),
        );

      case TabsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const TabsScreen(),
        );

      default:
    }
    return null;
  }
}
