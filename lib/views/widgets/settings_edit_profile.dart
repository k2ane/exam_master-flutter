import 'package:exam_master_flutter/models/user_model.dart';
import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/providers/secure_storage_provider.dart';
import 'package:exam_master_flutter/respositorys/auth_repository.dart';
import 'package:exam_master_flutter/views/widgets/profile_setting_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsEditProfile extends ConsumerStatefulWidget {
  const SettingsEditProfile({super.key});
  @override
  ConsumerState<SettingsEditProfile> createState() => _SettingsEditProfile();
}

class _SettingsEditProfile extends ConsumerState<SettingsEditProfile> {
  final Map<String, dynamic> data = {"name": '张同学', 'email': 'mint1944@qq.com'};
  late final sData;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      EasyLoading.show();
      final token = await ref.read(secureStorageProvider).getToken();
      if (token != null) {
        try {
          final CheckStatusResponse response = await ref
              .read(authRepositoryProvider)
              .checkLoginState(token);
          sData = response;
          await ref
              .read(authStateProvider.notifier)
              .checkLoginState(
                response.content['token'],
                response.content['email'],
                response.content['id'],
                response.content['name'],
                response.content['role'],
              );
          EasyLoading.dismiss();
        } catch (e) {
          debugPrint('身份验证异常: $e');
          // await ref.read(authStateProvider.notifier).logout();
          if (mounted) {
            EasyLoading.dismiss();
            context.pop();
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red.shade600,
                content: Text('$e'),
              ),
            );
          }
        }
      } else {
        // 没有获取到token，判断用户未登陆
        EasyLoading.dismiss();
        await ref.read(authStateProvider.notifier).logout();
        if (mounted) {
          context.go('/login');
        }
      }
    });
  }

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
