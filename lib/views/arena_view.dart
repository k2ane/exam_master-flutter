import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArenaView extends ConsumerWidget {
  const ArenaView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('竞技场', style: TextStyle(fontSize: 36)),
        centerTitle: false,
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: Text('竞技场页面')),
    );
  }
}
