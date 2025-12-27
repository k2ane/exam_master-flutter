import 'package:exam_master_flutter/features/auth/view/exam_page.dart';
import 'package:exam_master_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../placeholder_page.dart';

class D_MainNavigationScaffold extends StatefulWidget {
  const D_MainNavigationScaffold({super.key});

  @override
  State<D_MainNavigationScaffold> createState() =>
      _D_MainNavigationScaffoldState();
}

class _D_MainNavigationScaffoldState extends State<D_MainNavigationScaffold> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              leading: FloatingActionButton(
                tooltip: "添加功能",
                onPressed: () => {},
                child: Icon(Icons.add),
              ),
              groupAlignment: -1.0,
              selectedIndex: _selectIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  padding: EdgeInsets.only(top: 20),
                  icon: Icon(Icons.sports_martial_arts_outlined),
                  selectedIcon: Icon(Icons.sports_martial_arts),
                  label: Text('竞技场'),
                ),
                NavigationRailDestination(
                  padding: EdgeInsets.only(top: 15),
                  icon: Icon(Icons.leaderboard_outlined),
                  selectedIcon: Icon(Icons.leaderboard),
                  label: Text('排名'),
                ),
                NavigationRailDestination(
                  padding: EdgeInsets.only(top: 15),
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: Text('我'),
                ),
                NavigationRailDestination(
                  padding: EdgeInsets.only(top: 15),
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: Text('关于'),
                ),
              ],
            ),
            VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: <Widget>[
                ExamPage(),
                PlaceholderPage(title: '排行', icon: Icons.abc),
                PlaceholderPage(title: '我', icon: Icons.abc),
                PlaceholderPage(title: '关于系统', icon: Icons.abc),
              ][_selectIndex],
            ),
            // Column(children: <Widget>[Text('selectedIndex: $_selectIndex')]),
          ],
        ),
      ),
    );
  }
}
