import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';
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
    return AppcontainerWidget(
      viewTitle: '排行榜',
      viewSubTitle: '与其他用户一较高下',
      children: [Text('排行榜页面')],
    );
  }
}
