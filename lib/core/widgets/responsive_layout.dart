import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget? table; // 可选平板布局

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.desktop,
    this.table,
  });

  static const int mobileBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileBreakpoint) {
          return mobile;
        } else {
          return desktop;
        }
      },
    );
  }
}
