import 'package:exam_master_flutter/features/auth/view/arena_page.dart';
import 'package:exam_master_flutter/features/auth/view/me_page.dart';
import 'package:exam_master_flutter/features/auth/view/rank_page.dart';
import 'package:exam_master_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MMainNavigationScaffold extends StatefulWidget {
  const MMainNavigationScaffold({super.key});

  @override
  State<MMainNavigationScaffold> createState() =>
      _MMainNavigationScaffoldState();
}

class _MMainNavigationScaffoldState extends State<MMainNavigationScaffold> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
        selectedIndex: _selectIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.sports_martial_arts),
            icon: Icon(Icons.sports_martial_arts_outlined),
            label: "竞技场",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.leaderboard),
            icon: Icon(Icons.leaderboard_outlined),
            label: "排行",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: "我",
          ),
        ],
      ),
      body: <Widget>[ArenaPage(), RankPage(), MePage()][_selectIndex],
    );
  }
}
