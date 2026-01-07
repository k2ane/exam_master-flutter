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
      appBar: AppBar(
        title: Text('排行榜', style: TextStyle(fontSize: 36)),
        centerTitle: false,
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: Text('排行榜页面')),
    );
  }
}
