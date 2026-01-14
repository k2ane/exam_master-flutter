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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 8),
            Card(
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.person_outline),
                ),
                title: Text('个人信息'),
                subtitle: Text(
                  '查看或修改您的个人信息',
                  style: TextStyle().copyWith(fontSize: 12),
                ),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
            SizedBox(height: 8),
            Card(
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.cloud_outlined),
                ),
                title: Text('云存储'),
                subtitle: Text(
                  '管理您的云端数据',
                  style: TextStyle().copyWith(fontSize: 12),
                ),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
            SizedBox(height: 8),
            Card(
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.logout_outlined),
                ),
                title: Text('退出登陆'),
                subtitle: Text(
                  '从此设备退出登陆状态',
                  style: TextStyle().copyWith(fontSize: 12),
                ),
                trailing: Icon(Icons.chevron_right_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
