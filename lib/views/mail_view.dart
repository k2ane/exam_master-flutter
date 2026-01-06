import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';

class MailView extends ConsumerStatefulWidget {
  const MailView({super.key});
  @override
  ConsumerState<MailView> createState() => _MailView();
}

class _MailView extends ConsumerState<MailView> {
  @override
  Widget build(BuildContext context) {
    return AppcontainerWidget(
      viewTitle: '收件箱',
      viewSubTitle: '接受来自其他用户以及系统的最新消息',
      children: [Text('这是收件箱页面')],
    );
  }
}
