import 'package:exam_master_flutter/features/auth/view/exam_page.dart';
import 'package:exam_master_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../placeholder_page.dart';

class M_MainNavigationScaffold extends StatefulWidget {
  const M_MainNavigationScaffold({super.key});

  @override
  State<M_MainNavigationScaffold> createState() =>
      _M_MainNavigationScaffoldState();
}

class _M_MainNavigationScaffoldState extends State<M_MainNavigationScaffold> {
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
          NavigationDestination(
            selectedIcon: Icon(Icons.info_outline),
            icon: Icon(Icons.info),
            label: "关于",
          ),
        ],
      ),
      body: <Widget>[
        ExamPage(),
        PlaceholderPage(title: '排行', icon: Icons.leaderboard),
        PlaceholderPage(title: '我', icon: Icons.person),
        PlaceholderPage(title: '关于', icon: Icons.info),
      ][_selectIndex],
    );
  }
}
