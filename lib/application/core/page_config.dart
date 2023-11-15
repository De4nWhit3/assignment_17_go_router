import 'package:flutter/material.dart';

class PageConfig {
  final IconData icon;
  final String name;
  final Widget child; // widget to display when this tab is selected

  const PageConfig({
    required this.icon,
    required this.name,
    Widget? child,
  }) : child = child ?? const Placeholder();
}
