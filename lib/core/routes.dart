import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_3/application/pages/home/home_page.dart';
import 'package:todo_app_3/core/app_routes.dart';

final routes = GoRouter(
  initialLocation: AppRoutes.settings,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) {
        return Container(
          color: Colors.amber,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go(AppRoutes.home);
                },
                child: const Text('Go to home'),
              ),
              Material(
                child: IconButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.home);
                    }
                  },
                  icon: const Icon(Icons.heart_broken),
                ),
              )
            ],
          ),
        );
      },
    ),
  ],
);
