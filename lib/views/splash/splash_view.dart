import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/providers/secure_storage_provider.dart';
import 'package:exam_master_flutter/respositorys/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});
  @override
  ConsumerState<SplashView> createState() => _SplashView();
}

class _SplashView extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkLoginState(context);
    });
  }

  Future<void> _checkLoginState(BuildContext context) async {
    await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      initCheckAuth(),
    ]);
  }

  Future<void> initCheckAuth() async {
    debugPrint('开始获取安全存储的token');
    final token = await ref.read(secureStorageProvider).getToken();
    if (token != null) {
      debugPrint('token获取成功: $token');
      try {
        final response = await ref
            .read(authRepositoryProvider)
            .checkLoginState(token as String);
        if (response.status != 'success') {
          debugPrint('身份验证错误');
          await ref.read(authStateProvider.notifier).logout();
          if (mounted) {
            context.go('/login');
          }
        } else {
          debugPrint('身份验证成功');
          await ref
              .read(authStateProvider.notifier)
              .checkLoginState(
                response.content['token'],
                response.content['email'],
                response.content['id'],
                response.content['name'],
                response.content['role'],
              );
          if (mounted) {
            if (ref.watch(authStateProvider).value == true) {
              context.go('/');
            }
          }
        }
      } catch (e) {
        debugPrint('身份验证异常: $e');
        // await ref.read(authStateProvider.notifier).logout();
        if (mounted) {
          context.go('/');
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red.shade600, content: Text('$e')),
          );
        }
      }
    } else {
      await ref.read(authStateProvider.notifier).logout();
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade600,
            content: Text('没有获取到安全存储的token,用户未登陆'),
          ),
        );
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final kIsDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              kIsDark
                  ? 'assets/logo/logo_dark.png'
                  : 'assets/logo/logo_light.png',
              width: 256,
              height: 256,
            ),
            CircularProgressIndicator(),
            SizedBox(height: 32),
            Text('我们正在处理您的信息...'),
          ],
        ),
      ),
    );
  }
}
