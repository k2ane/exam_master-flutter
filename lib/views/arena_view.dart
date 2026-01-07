import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArenaView extends ConsumerWidget {
  const ArenaView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('竞技场')),
      body: Text('竞技场页面'),
    );
  }
}
