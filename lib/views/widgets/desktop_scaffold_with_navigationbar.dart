import 'package:exam_master_flutter/views/widgets/navigationbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DesktopScaffoldWithNavigationbar extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DesktopScaffoldWithNavigationbar({
    super.key,
    required this.navigationShell,
  });

  @override
  ConsumerState<DesktopScaffoldWithNavigationbar> createState() =>
      _DesktopScaffoldWithNavigationbar();
}

class _DesktopScaffoldWithNavigationbar
    extends ConsumerState<DesktopScaffoldWithNavigationbar> {
  @override
  Widget build(BuildContext context) {
    final List<NavigationbarItem> items = navConfig;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            leading: SizedBox(height: 4),
            trailing: SizedBox(height: 4),
            labelType: NavigationRailLabelType.all,
            selectedIndex: widget.navigationShell.currentIndex,
            onDestinationSelected: (value) => widget.navigationShell.goBranch(
              value,
              initialLocation: value == widget.navigationShell.currentIndex,
            ),
            destinations: items.map((items) {
              return NavigationRailDestination(
                icon: Icon(items.icon),
                label: Text(items.label),
                selectedIcon: Icon(items.selectedIcon),
              );
            }).toList(),
          ),
          Expanded(flex: 1, child: widget.navigationShell),
        ],
      ),
    );
  }
}
