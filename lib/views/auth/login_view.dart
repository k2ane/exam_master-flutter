import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/providers/global_email_provider.dart';
import 'package:exam_master_flutter/respositorys/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<LoginView> createState() => _LoginView();
}

class _LoginView extends ConsumerState<LoginView> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passcodeFormKey = GlobalKey<FormState>();
  final TextEditingController _passcodeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  var isEmailSend = false;
  var showPasscode = false;

  @override
  dispose() {
    _emailController.dispose();
    _passcodeController.dispose();
    isEmailSend = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final login = ref.read(authRepositoryProvider);
    final globalEmail = ref.read(globalEmailProvider.notifier);
    final authState = ref.read(authStateProvider.notifier);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: constraints.constrainWidth() > 500
                    ? 600
                    : double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: constraints.constrainWidth() > 650
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('认证', style: TextStyle().copyWith(fontSize: 48)),
                        Text(
                          '以继续使用该系统',
                          style: TextStyle().copyWith(
                            fontSize: 16,
                            color: Colors.black.withAlpha(150),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36.0),
                    Offstage(
                      offstage: isEmailSend == true ? false : true,
                      child: Form(
                        key: _passcodeFormKey,
                        child: TextFormField(
                          controller: _passcodeController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '请输入验证码';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('验证码'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: isEmailSend == true ? true : false,
                      child: Form(
                        key: _emailFormKey,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '请输入邮箱';
                            }
                            final regexp = RegExp(
                              r'\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}',
                            );
                            if (!regexp.hasMatch(value)) {
                              return '请输入正确的邮箱格式';
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                            label: Text('邮箱'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.0),
                    SizedBox(
                      width: constraints.constrainWidth() > 500
                          ? 150
                          : double.infinity,
                      child: Offstage(
                        offstage: isEmailSend,
                        child: FilledButton(
                          onPressed: () async {
                            if (_emailFormKey.currentState!.validate()) {
                              globalEmail.state = _emailController.text;
                              try {
                                final data = await login
                                    .sendEmailVerificationCode(
                                      _emailController.text,
                                    );
                                if (context.mounted) {
                                  showMessage(
                                    Colors.green.shade600,
                                    data.content['message'],
                                    context,
                                    true,
                                  );
                                  setState(() {
                                    isEmailSend = !isEmailSend;
                                  });
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  showMessage(
                                    Colors.red.shade600,
                                    e.toString(),
                                    context,
                                    false,
                                  );
                                  // setState(() {
                                  //   isEmailSend = !isEmailSend;
                                  // });
                                }
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('下一步'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.constrainWidth() > 500
                          ? 150
                          : double.infinity,
                      child: Offstage(
                        offstage: !isEmailSend,
                        child: FilledButton(
                          onPressed: () async {
                            if (_passcodeFormKey.currentState!.validate()) {
                              await EasyLoading.show();
                              try {
                                final data = await login.sigIn(
                                  _emailController.text,
                                  _passcodeController.text,
                                );
                                if (context.mounted) {
                                  if (data.status == 'success' &&
                                      data.content['token']
                                          .toString()
                                          .isNotEmpty) {
                                    await EasyLoading.dismiss();
                                    authState.loginSuccess(
                                      data.content['token'],
                                      data.content['email'],
                                      data.content['id'],
                                    );
                                    if (context.mounted) {
                                      showMessage(
                                        Colors.green.shade600,
                                        data.content['message'],
                                        context,
                                        true,
                                      );
                                    }
                                    if (context.mounted) {
                                      context.go('/');
                                    }
                                  }
                                }
                              } catch (e) {
                                if (EasyLoading.isShow) {
                                  EasyLoading.dismiss();
                                }
                                if (context.mounted) {
                                  showMessage(
                                    Colors.red.shade600,
                                    e.toString(),
                                    context,
                                    false,
                                  );
                                }
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('验证'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<void> showMessage(
  Color backgroundColor,
  String message,
  BuildContext context,
  bool isTrue,
) async {
  // 先清理之前的snakeBar
  ScaffoldMessenger.of(context).clearSnackBars();
  // 显示错误snakeBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: isTrue ? Text('正确: $message') : Text('错误: $message'),
    ),
  );
}
