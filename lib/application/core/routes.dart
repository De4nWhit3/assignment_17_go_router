import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_3/application/app/pages/home/home_page.dart';
import 'package:todo_app_3/application/app/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRoutes {
  static const String home = '/home';
  static const String settings = '/home/settings';
}

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '${AppRoutes.home}/dashboard',
  routes: [
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: '${AppRoutes.home}/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab'] ?? 'dashboard',
          ),
        ),
      ],
    ),
  ],
);
