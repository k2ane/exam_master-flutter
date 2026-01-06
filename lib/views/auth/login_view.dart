import 'package:exam_master_flutter/providers/global_email_provider.dart';
import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<LoginView> createState() => _LoginView();
}

class _LoginView extends ConsumerState<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  @override
  dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppcontainerWidget(
      viewTitle: '登录',
      viewSubTitle: '我们需要验证您的身份以继续',
      children: [
        Form(
          key: _fromKey,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              // 验证用户是否有输入内容
              if (value == null || value.isEmpty) {
                return '请输入邮箱';
              }
              final RegExp emailExp = RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              );
              if (!emailExp.hasMatch(value)) {
                return '请输入正确的邮箱格式';
              }
              // 通过验证
              return null;
            },
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: '邮箱',
              border: OutlineInputBorder(),
              hintText: 'eg: example@gmail.com',
            ),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              '点击',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            Text(
              '下一步',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              '即代表您同意我们的隐私政策',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),

        SizedBox(height: 24),
        FilledButton(
          onPressed: () => {
            //确定用户输入的内容已经通过验证
            if (_fromKey.currentState!.validate())
              {
                // 将用户输入的邮箱传递到全局
                ref.read(globalEmailProvider.notifier).state =
                    _emailController.text,
                // 前往下一个路由
                context.go('/login/verification'),
              },
          },
          child: Text('下一步'),
        ),
      ],
    );
  }
}
