import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 引入生成的 ViewModel 和 翻译文件
import '../logic/login_controller.dart';
import '../../../l10n/app_localizations.dart';
// (注意调整上面的 import 路径，确保指向正确文件)

// ✅ 关键点：继承 ConsumerWidget 而不是 StatelessWidget
// 这样我们就能通过 WidgetRef ref 来与 ViewModel 通信
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    // 1. 监听 ViewModel 的状态
    // watch: 只要状态变了（比如变成 loading），界面就会自动刷新
    final loginState = ref.watch(loginControllerProvider);

    // 2. 监听副作用 (Side Effects)
    // listen: 用于处理导航、弹窗报错等一次性操作
    ref.listen(loginControllerProvider, (previous, next) {
      if (next.hasError) {
        // 报错弹窗
        showPlatformDialog(
          context: context,
          builder: (_) => PlatformAlertDialog(
            title: const Text('错误'),
            content: Text(next.error.toString()),
            actions: [
              PlatformDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      } else if (!next.isLoading && !next.hasError) {
        // 成功跳转
        // Navigator.pushReplacement...
        print("登录成功，跳转首页");
      }
    });

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text(l10n.loginTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.loginTiitleMessage),

              const SizedBox(height: 32),

              PlatformTextField(
                controller: emailController,
                hintText: l10n.inputEmail,
                enabled: !loginState.isLoading, // 加载时禁用输入
              ),
              const SizedBox(height: 16),
              PlatformTextField(
                controller: passwordController,
                hintText: l10n.inputPassword,
                obscureText: true,
                enabled: !loginState.isLoading,
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: PlatformElevatedButton(
                  // 如果正在加载，显示转圈圈；否则显示文字
                  child: loginState.isLoading
                      ? PlatformCircularProgressIndicator()
                      : Text(l10n.btnLogin),
                  onPressed: loginState.isLoading
                      ? null // 加载时禁用按钮
                      : () {
                          // ✅ 3. 触发 ViewModel 的方法
                          // read: 调用方法时不监控状态变化，只触发一次
                          ref
                              .read(loginControllerProvider.notifier)
                              .login(
                                emailController.text,
                                passwordController.text,
                              );
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
