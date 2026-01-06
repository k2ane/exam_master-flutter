import 'package:exam_master_flutter/views/arena_view.dart';
import 'package:exam_master_flutter/views/leader_board_view.dart';
import 'package:exam_master_flutter/views/mail_view.dart';
import 'package:exam_master_flutter/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopLayout extends ConsumerStatefulWidget {
  const DesktopLayout({super.key});

  @override
  ConsumerState<DesktopLayout> createState() => _DesktopLayout();
}

class _DesktopLayout extends ConsumerState<DesktopLayout> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: NavigationRail(
            trailingAtBottom: true,
            // 底部设置按钮
            trailing: IconButton(
              onPressed: () => {},
              icon: Icon(Icons.settings),
              tooltip: '设置',
            ),
            // 试炼场
            destinations: [
              NavigationRailDestination(
                padding: EdgeInsets.symmetric(vertical: 4),
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('试炼场'),
              ),
              // 排行榜
              NavigationRailDestination(
                padding: EdgeInsets.symmetric(vertical: 4),
                selectedIcon: Icon(Icons.leaderboard),
                icon: Icon(Icons.leaderboard_outlined),
                label: Text('排行榜'),
              ),
              // 收件箱 - 暂未开发
              NavigationRailDestination(
                padding: EdgeInsets.symmetric(vertical: 4),
                selectedIcon: Icon(Icons.mail),
                icon: Icon(Icons.mail_outline),
                label: Text('收件箱'),
              ),

              // 个人资料
              NavigationRailDestination(
                padding: EdgeInsets.symmetric(vertical: 4),
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline),
                label: Text('个人资料'),
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) => {
              setState(() {
                selectedIndex = value;
              }),
            },
            labelType: NavigationRailLabelType.all,
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
          color: Theme.of(context).colorScheme.outlineVariant.withAlpha(150),
        ),
        Expanded(
          child: [
            ArenaView(),
            LeaderBoardView(),
            MailView(),
            ProfileView(),
          ][selectedIndex],
        ),
      ],
    );
  }
}
