import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/corral/corral_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../providers/cattle_provider.dart';
import '../main.dart'; // Home

class AppRoutes {
  static const String home = '/';
  static const String corral = '/corral';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const MyHomePage(title: 'Bovino App'),
    corral: (context) => const CorralScreen(),
    dashboard: (context) => const DashboardScreen(),
  };
}
