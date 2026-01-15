import 'package:exam_master_flutter/views/widgets/profile_setting_card_widget.dart';
import 'package:exam_master_flutter/views/widgets/user_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});
  @override
  ConsumerState<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人资料'),
        centerTitle: false,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),
        actions: [
          IconButton.filled(
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('功能暂未提供')));
            },
            icon: Icon(Icons.palette_outlined),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          UserInfoCardWidget(),
          SizedBox(height: 12),
          ProfileSettingCardWidget(
            title: '设置',
            description: '系统及账户设置',
            ontap: () => context.go('/profile/settings'),
            icon: Icon(Icons.settings_outlined),
            iconBackground: Colors.indigo,
          ),
          SizedBox(height: 8),
          ProfileSettingCardWidget(
            title: '帮助与反馈',
            description: '反馈使用过程中的问题',
            icon: Icon(Icons.help_outline),
            iconBackground: Colors.orange.shade600,
            ontap: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('功能暂未提供')));
            },
          ),
          SizedBox(height: 8),
          ProfileSettingCardWidget(
            title: '关于',
            description: 'v1.0.0 build5',
            icon: Icon(Icons.info_outline),
            iconBackground: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}
