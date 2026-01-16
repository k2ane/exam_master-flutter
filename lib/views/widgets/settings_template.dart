import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/views/widgets/profile_setting_card_widget.dart';
import 'package:exam_master_flutter/views/widgets/settings_edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsTemplate extends ConsumerWidget {
  final String pageTitle;
  const SettingsTemplate({super.key, required this.pageTitle});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 8),
            ProfileSettingCardWidget(
              title: '个人信息',
              description: '查看或修改您的个人信息',
              icon: Icon(Icons.person_outline),
              iconBackground: Colors.teal,
              iconForeground: Colors.white,
              ontap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsEditProfile()),
              ),
            ),
            SizedBox(height: 8),
            ProfileSettingCardWidget(
              title: '云存储',
              description: '管理您的云端数据',
              icon: Icon(Icons.cloud_outlined),
              iconBackground: Colors.lightGreen,
              iconForeground: Colors.white,
              ontap: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('功能暂未提供')));
              },
            ),
            SizedBox(height: 8),
            ProfileSettingCardWidget(
              title: '退出登陆',
              description: '从此设备退出登陆状态',
              icon: Icon(Icons.logout_outlined),
              iconBackground: Colors.red,
              iconForeground: Colors.white,
              ontap: () => showlogoutDialog(context, () => authState.logout()),
            ),
          ],
        ),
      ),
    );
  }
}
