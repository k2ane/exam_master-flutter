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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppbarWidget(
          viewTitle: '关于我',
          viewSubTitle: '查看与管理您的个人信息',
          showBackButton: false,
        ),
      ],
    );
  }
}
