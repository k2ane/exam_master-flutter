import 'package:exam_master_flutter/views/arena_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneLayout extends ConsumerStatefulWidget {
  const PhoneLayout({super.key});
  @override
  ConsumerState<PhoneLayout> createState() => _PhoneLayout();
}

class _PhoneLayout extends ConsumerState<PhoneLayout> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: [ArenaView(), ArenaView(), ArenaView()][selectedIndex]),
        NavigationBar(
          maintainBottomViewPadding: false,
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.abc), label: 'ABV'),
            NavigationDestination(icon: Icon(Icons.abc), label: 'ABV'),
            NavigationDestination(icon: Icon(Icons.abc), label: 'ABV'),
          ],
        ),
      ],
    );
  }
}
