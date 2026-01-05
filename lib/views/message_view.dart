import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:exam_master_flutter/views/widgets/appbar_widget.dart';

class MessageView extends ConsumerStatefulWidget {
  const MessageView({super.key});
  @override
  ConsumerState<MessageView> createState() => _MessageView();
}

class _MessageView extends ConsumerState<MessageView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppbarWidget(
          viewTitle: '消息',
          viewSubTitle: '查看最新通知',
          showBackButton: false,
        ),
      ],
    );
  }
}
