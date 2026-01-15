import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionView extends ConsumerStatefulWidget {
  const QuestionView({super.key});
  @override
  ConsumerState<QuestionView> createState() => _QuestionView();
}

class _QuestionView extends ConsumerState<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('基础题库')),
      body: Text('基础题库页面...'),
    );
  }
}
