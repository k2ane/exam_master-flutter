import 'package:exam_master_flutter/views/templates/text_question_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SequentialExamView extends ConsumerStatefulWidget {
  const SequentialExamView({super.key});

  @override
  ConsumerState<SequentialExamView> createState() => _SequentialExamView();
}

class _SequentialExamView extends ConsumerState<SequentialExamView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),
        actions: [
          IconButton.filled(
            onPressed: () => {},
            icon: Icon(
              Icons.assistant_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            tooltip: 'AI解题',
          ),
        ],
        titleSpacing: 0,
        toolbarHeight: 104,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '顺序练题',
                  style: TextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                Text(
                  '按照固定顺序进行练习',
                  style: TextStyle().copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: TextQuestionTemplate(),
    );
  }
}
