import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_3/application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app_3/application/pages/overview/overview_page.dart';
import 'package:todo_app_3/core/routes.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }) : index = tabs.indexWhere((element) => element.name == tab);

  final int index;

  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map(
        (page) => NavigationDestination(
          icon: Icon(page.icon),
          label: page.name,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('primary-navigation-medium'),
                builder: (context) {
                  return AdaptiveScaffold.standardNavigationRail(
                    destinations: destinations
                        .map((element) =>
                            AdaptiveScaffold.toRailDestination(element))
                        .toList(),
                    onDestinationSelected: (index) =>
                        _tapOnNavigationDestination(context, index),
                  );
                },
              )
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('bottom-nav-small'),
                builder: (context) {
                  return AdaptiveScaffold.standardBottomNavigationBar(
                    destinations: destinations,
                    onDestinationSelected: (value) =>
                        _tapOnNavigationDestination(context, value),
                  );
                },
              ),
            },
          ),
          body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('primary-body'),
              builder: (context) {
                return const Placeholder();
              },
            )
          }),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('secondary-body'),
                builder: (context) => const Placeholder(),
              ),
            },
          ),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.go('${AppRoutes.home}/${HomePage.tabs[index].name}');
}
