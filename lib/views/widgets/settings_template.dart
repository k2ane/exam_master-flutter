import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsTemplate extends ConsumerWidget {
  final String pageTitle;
  const SettingsTemplate({super.key, required this.pageTitle});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () => ref.watch(authStateProvider.notifier).logout(),
              title: Text('标题'),
              subtitle: Text('副标题'),
            ),
          );
        },
      ),
    );
  }
}
