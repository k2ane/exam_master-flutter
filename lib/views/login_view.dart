import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppcontainerWidget(
      viewTitle: '登录',
      viewSubTitle: '以继续使用 Bondex 训练场',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            child: TextFormField(
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
            onPressed: () => {context.go('/login/verification')},
            child: Text('下一步'),
          ),
        ],
      ),
    );
  }
}
