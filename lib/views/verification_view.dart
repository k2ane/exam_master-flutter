import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationView extends ConsumerWidget {
  const VerificationView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppcontainerWidget(
      viewTitle: '验证',
      viewSubTitle: '请输入6位验证码',
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: '验证码',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            '59s后可重试',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary.withAlpha(200),
            ),
          ),
          SizedBox(height: 24),
          FilledButton(onPressed: () => {}, child: Text('验证')),
        ],
      ),
    );
  }
}
