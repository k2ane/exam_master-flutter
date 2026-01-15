import 'package:exam_master_flutter/views/widgets/profile_setting_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsEditProfile extends ConsumerStatefulWidget {
  const SettingsEditProfile({super.key});
  @override
  ConsumerState<SettingsEditProfile> createState() => _SettingsEditProfile();
}

class _SettingsEditProfile extends ConsumerState<SettingsEditProfile> {
  final Map<String, dynamic> data = {"name": '张同学', 'email': 'mint1944@qq.com'};

  @override
  Widget build(BuildContext context) {
    final keys = data.keys.toList();
    return Scaffold(
      appBar: AppBar(title: Text('个人信息')),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final key = keys[index];
          final value = data[key];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ProfileSettingCardWidget(title: key, description: value),
          );
        },
      ),
    );
  }
}
