import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/providers/http_cilent_provider.dart';
import 'package:exam_master_flutter/providers/secure_storage_provider.dart';
import 'package:exam_master_flutter/respositorys/auth_repository.dart';
import 'package:exam_master_flutter/views/widgets/navigationbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PhoneScaffoldWithNavigationbar extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const PhoneScaffoldWithNavigationbar({
    super.key,
    required this.navigationShell,
  });
  @override
  ConsumerState<PhoneScaffoldWithNavigationbar> createState() =>
      _PhoneScaffoldWithNavigationbar();
}

class _PhoneScaffoldWithNavigationbar
    extends ConsumerState<PhoneScaffoldWithNavigationbar> {
  @override
  Widget build(BuildContext context) {
    final storage = ref.read(secureStorageProvider);
    final authState = ref.read(authRepositoryProvider);
    final List<NavigationbarItem> items = navConfig;
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (value) async {
          widget.navigationShell.goBranch(
            value,
            initialLocation: value == widget.navigationShell.currentIndex,
          );
          final token = await storage.getToken();
          final response = await authState.checkLoginState(token as String);
          if (context.mounted) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${response.content['message']}')),
            );
          }
        },
        destinations: items.map((items) {
          return NavigationDestination(
            icon: items.badgeTitle != null
                ? Badge(
                    label: Text(items.badgeTitle ?? ''),
                    child: Icon(items.icon),
                  )
                : Icon(items.icon),
            label: items.label,
            selectedIcon: items.badgeTitle != null
                ? Badge(
                    label: Text(items.badgeTitle ?? ''),
                    child: Icon(items.selectedIcon),
                  )
                : Icon(items.selectedIcon),
          );
        }).toList(),
      ),
    );
  }
}
