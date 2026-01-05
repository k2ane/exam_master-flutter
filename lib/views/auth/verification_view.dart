import 'dart:async';
import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/providers/global_email_provider.dart';
import 'package:exam_master_flutter/respositorys/auth_repository.dart';
import 'package:exam_master_flutter/respositorys/login_repository.dart';
import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VerificationView extends ConsumerStatefulWidget {
  const VerificationView({super.key});
  @override
  ConsumerState<VerificationView> createState() => _VerificationView();
}

class _VerificationView extends ConsumerState<VerificationView> {
  int downCount = 60;
  bool isCount = false;
  bool fristClicked = true;
  Timer? _timer;

  final TextEditingController _passcodeController = TextEditingController();

  Future<void> startDownCount() async {
    // 取消旧的计时器
    _timer?.cancel();
    debugPrint('进入函数');
    // 检查倒计时是否已经启动
    if (downCount == 0) {
      setState(() {
        isCount = false;
      });
      EasyLoading.dismiss();
    } else {
      // 重置倒计时数
      downCount = 60;
      setState(() {
        isCount = true;
        fristClicked = false;
      });
      EasyLoading.dismiss();
      // 创建倒计时
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        debugPrint('进入函数');
        // 检查downCount是否为0， 如果为0则停止计时
        if (downCount == 0) {
          // 设置状态
          debugPrint('设置状态为未在计时');
          setState(() {
            isCount = false;
          });
          EasyLoading.dismiss();
          // 跳出循环
          // 取消计时器
          timer.cancel();
        } else {
          debugPrint('计时数值为：$downCount');
          setState(() {
            downCount--;
          });
        }
      });
    }
  }

  @override
  dispose() {
    _passcodeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = ref.read(globalEmailProvider);
    return AppcontainerWidget(
      viewTitle: '验证',
      viewSubTitle: !fristClicked
          ? '请输入发送至 @${email.split('@')[1]} 的验证码'
          : '点击按钮获取验证码',
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            child: TextFormField(
              controller: _passcodeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password_outlined),
                prefixText: 'B - ',
                labelText: '验证码',
                border: OutlineInputBorder(),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: isCount
                        ? null
                        : () async {
                            await EasyLoading.show(status: '正在获取');
                            try {
                              final response = await ref
                                  .read(authRepositoryProvider)
                                  .sendEmailVerificationCode(email);
                              if (response.status == 'success') {
                                // 重置状态
                                setState(() {
                                  downCount = 60;
                                });
                                startDownCount();
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response.message)),
                                );
                              }
                            } catch (e) {
                              EasyLoading.dismiss();
                              debugPrint('发送错误: $e');
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text('$e')));
                            }
                          },
                    child: Text(
                      isCount ? '${downCount}s后重试' : '获取验证码',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 24),
          FilledButton(
            onPressed: () async {
              try {
                final response = await ref
                    .read(loginRepositoryProvider)
                    .login(email, _passcodeController.text);
                if (response.status == 'success' && response.token.isNotEmpty) {
                  // 返回数据正确，将获取的token存储起来
                  await ref
                      .read(authStateProvider.notifier)
                      .loginSuccess(response.token);
                  // 返回正确消息
                  if (!context.mounted) return;
                  // 显示成功提示
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('登录成功')));
                  // 将用户转到首页
                  context.push('/home');
                } else {
                  // 返回失败消息
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('登录失败')));
                }
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('$e')));
              }
            },
            child: Text('验证'),
          ),
        ],
      ),
    );
  }
}
