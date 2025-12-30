import 'package:exam_master_flutter/views/shared/arena_page.dart';
import 'package:exam_master_flutter/views/shared/me_page.dart';
import 'package:exam_master_flutter/views/shared/rank_page.dart';
import 'package:exam_master_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DMainNavigationScaffold extends StatefulWidget {
  const DMainNavigationScaffold({super.key});

  @override
  State<DMainNavigationScaffold> createState() =>
      _DMainNavigationScaffoldState();
}

class _DMainNavigationScaffoldState extends State<DMainNavigationScaffold> {
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
                onPressed: () => _showRedeemCodeDialog(context: context),
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
              ],
            ),
            VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: <Widget>[
                ArenaPage(isShowButton: false),
                RankPage(),
                MePage(),
              ][_selectIndex],
            ),
            // Column(children: <Widget>[Text('selectedIndex: $_selectIndex')]),
          ],
        ),
      ),
    );
  }
}

Future<void> _showRedeemCodeDialog({required BuildContext context}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('激活题库'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "兑换码",
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('兑换'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
