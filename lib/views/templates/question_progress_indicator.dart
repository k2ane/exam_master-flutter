import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionProgressIndicator extends ConsumerStatefulWidget {
  const QuestionProgressIndicator({super.key});
  @override
  ConsumerState<QuestionProgressIndicator> createState() =>
      _QuestionProgressIndicator();
}

class _QuestionProgressIndicator
    extends ConsumerState<QuestionProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100, child: LinearProgressIndicator(value: 0.2)),
        Text('123123'),
        Text('123123'),
      ],
    );
  }
}
