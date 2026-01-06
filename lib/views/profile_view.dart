import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:exam_master_flutter/views/widgets/appbar_widget.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});
  @override
  ConsumerState<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return AppcontainerWidget(
      viewTitle: '关于我',
      viewSubTitle: '查看与管理您的个人资料',
      children: [
        FilledButton.icon(
          onPressed: () async {
            await ref.read(authStateProvider.notifier).logout();
          },
          label: Text('退出登录'),
          icon: Icon(Icons.logout),
          iconAlignment: IconAlignment.end,
        ),
      ],
    );
  }
}
