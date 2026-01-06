import 'package:exam_master_flutter/views/templates/question_answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextQuestionTemplate extends ConsumerStatefulWidget {
  const TextQuestionTemplate({super.key});
  @override
  ConsumerState<TextQuestionTemplate> createState() => _TextQuestionTemplate();
}

class _TextQuestionTemplate extends ConsumerState<TextQuestionTemplate> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 题目进度指示条
            // SizedBox(height: 16),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 16),
            // 题号 - 题目 - 题目类型
            Text(
              '题号: dcd1412sgewew-213bjkjdsf',
              style: TextStyle().copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
              ),
            ),
            Text(
              '进口货物的收货人、受委托的报关企业应当自交通运输工具申报进境之日起多少日内向海关申报？',
              style: TextStyle().copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Badge(
              label: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '单选题',
                  style: TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),

        SizedBox(height: 24),
        // 题目选项
        QuestionAnswer(),
      ],
    );
  }
}
