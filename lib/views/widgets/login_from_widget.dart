import 'package:exam_master_flutter/providers/login_state_provider.dart';
import 'package:exam_master_flutter/views/widgets/otp_widget.dart';
import 'package:exam_master_flutter/views/widgets/pop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFromWidget extends ConsumerStatefulWidget {
  const LoginFromWidget({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginFromWidget> {
  final _emailCtrl = TextEditingController();

  @override
  dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Bondex')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
                ),

                SizedBox(height: 40),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: InputDecoration(
                    labelText: '邮箱',
                    hintText: 'eg: user@bondex.com',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '* 未注册的邮箱将会自动创建账户',
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
                Row(
                  children: [
                    Text(
                      '* 点击下一步代表您同意我们的',
                      style: TextStyle(color: Colors.black38, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        '隐私政策',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Column(
                  children: [
                    FilledButton(
                      onPressed: () => {
                        ref.read(loginEmailProvider.notifier).state =
                            _emailCtrl.text,
                        showMyDialog(context, "身份认证", OtpWidget()),
                        // debugPrint('你点击了'),
                        // context.go('/login/otp'),
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('下一步'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
