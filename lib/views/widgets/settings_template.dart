import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsTemplate extends ConsumerWidget {
  final String pageTitle;
  const SettingsTemplate({super.key, required this.pageTitle});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('账户管理', style: TextStyle(fontSize: 36)),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              onTap: () {},
              // onTap: () => {ref.watch(authStateProvider.notifier).logout()},
              title: Text('标题'),
              subtitle: Text('副标题'),
            ),
          );
        },
      ),
    );
  }
}
