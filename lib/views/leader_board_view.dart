import 'package:exam_master_flutter/views/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderBoardView extends ConsumerStatefulWidget {
  const LeaderBoardView({super.key});
  @override
  ConsumerState<LeaderBoardView> createState() => _LeaderBoardView();
}

class _LeaderBoardView extends ConsumerState<LeaderBoardView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppbarWidget(
          viewTitle: '排行榜',
          viewSubTitle: '查看你的排名',
          showBackButton: false,
        ),
      ],
    );
  }
}
