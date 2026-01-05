import 'package:exam_master_flutter/views/arena_view.dart';
import 'package:exam_master_flutter/views/leader_board_view.dart';
import 'package:exam_master_flutter/views/profile_view.dart';
import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppcontainerWidget(
      showBackButton: false,
      isMainView: true,
      viewTitle: '训练场',
      viewSubTitle: '选择你的试炼',
      navigationDestination: [
        NavigationDestination(
          selectedIcon: Icon(Icons.dashboard),
          icon: Icon(Icons.dashboard_outlined),
          label: '训练场',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.emoji_events),
          icon: Icon(Icons.emoji_events_outlined),
          label: '排行榜',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outline),
          label: '个人资料',
        ),
      ],
      navigationWidgets: [ArenaView(), LeaderBoardView(), ProfileView()],
    );
  }
}
