import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponsiveLayout extends ConsumerWidget {
  // 手机视图
  final Widget phone;
  // 桌面视图
  final Widget desktop;
  // 平板视图
  final Widget? pad;

  const ResponsiveLayout({
    super.key,
    required this.phone,
    required this.desktop,
    this.pad,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 如果页面最大宽度小于 600 就认为设备是手机, 大于 600 认为设备为桌面
        return constraints.maxWidth < 600 ? phone : desktop;
      },
    );
  }
}
