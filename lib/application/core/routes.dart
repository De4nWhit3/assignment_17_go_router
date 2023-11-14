import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRoutes {
  static const String home = '/home/start';
  static const String settings = '/home/settings';
}

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) {
        return Container(
          color: Colors.amber,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.home);
                },
                child: const Text('Go to start'),
              ),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push(AppRoutes.home);
                  }
                },
                child: const Text('Go home'),
              ),
            ],
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) {
        return Container(
          color: Colors.blue,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.settings);
                },
                child: const Text('Go to settings'),
              ),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push(AppRoutes.settings);
                  }
                },
                child: const Text('Go settings'),
              ),
            ],
          ),
        );
      },
    ),
  ],
);
