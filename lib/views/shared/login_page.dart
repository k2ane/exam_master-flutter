import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var saveLoginState = false;
  final TextEditingController _emailController = TextEditingController();

  @override
  dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bondex',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: Scrollbar(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    final RegExp emailExp = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (value == null || value.isEmpty) {
                      return '邮箱不能为空';
                    }
                    if (!emailExp.hasMatch(value)) {
                      return '请输入正确的邮箱格式';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  // maxLength: 255,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: '邮箱',
                    hintText: 'example@jhonappleseed.com',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: FilledButton(
                    style: FilledButton.styleFrom(iconSize: 32),
                    onPressed: () => {
                      if (_formKey.currentState!.validate())
                        {
                          debugPrint('验证通过，正在提交...'),
                          context.go(
                            '/login/otp',
                            extra: _emailController.text,
                          ),
                        },
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('下一步')],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
