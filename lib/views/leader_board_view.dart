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
    return Scaffold(
      appBar: AppBar(title: Text('排行榜')),
      body: Text('排行榜页面'),
    );
  }
}
