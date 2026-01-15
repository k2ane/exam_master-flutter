import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageView extends ConsumerStatefulWidget {
  const MessageView({super.key});
  @override
  ConsumerState<MessageView> createState() => _MessageView();
}

class _MessageView extends ConsumerState<MessageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('收件箱')),
      body: Text('收件箱页面'),
    );
  }
}
