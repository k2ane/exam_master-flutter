import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpWidget extends ConsumerWidget {
  const OtpWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final email = ref.watch(loginEmailProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: .start,
      children: [
        // Text(email.isEmpty ? "未提供" : email),
        TextField(
          decoration: InputDecoration(
            labelText: '验证码',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '*请输入发送至的6位数字验证码',
              style: TextStyle(
                color: isDark ? Colors.white38 : Colors.black38,
                fontSize: 12,
              ),
            ),
            // SizedBox(height: 4),
            // Text(
            //   '没收到验证码? 59 秒后可重试',
            //   style: TextStyle(
            //     color: isDark ? Colors.white70 : Colors.black87,
            //     fontSize: 12,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
