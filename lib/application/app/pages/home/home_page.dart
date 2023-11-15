import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_3/application/app/pages/dashboard/dashboard_page.dart';
import 'package:todo_app_3/application/app/pages/overview/overview_page.dart';
import 'package:todo_app_3/application/core/routes.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab, // name of the current route
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
          primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('primary-navigation-medium'),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                selectedIndex: widget.index,
                destinations: destinations
                    .map((element) =>
                        AdaptiveScaffold.toRailDestination(element))
                    .toList(),
                onDestinationSelected: (index) =>
                    _tapOnNavigationDestination(context, index),
              ),
            )
          }),
          bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('bottom-navigation-small'),
              builder: (context) =>
                  AdaptiveScaffold.standardBottomNavigationBar(
                currentIndex: widget.index,
                destinations: destinations,
                onDestinationSelected: (index) =>
                    _tapOnNavigationDestination(context, index),
              ),
            )
          }),
          body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('primary-body'),
              builder: (context) => HomePage.tabs[widget.index].child,
            ),
          }),
          secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('secondary-body'),
              builder: AdaptiveScaffold.emptyBuilder,
            ),
          }),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.go('${AppRoutes.home}/${HomePage.tabs[index].name}');
}
