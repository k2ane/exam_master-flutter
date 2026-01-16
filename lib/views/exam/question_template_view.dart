import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class QuestionTemplateView extends ConsumerStatefulWidget {
  final String question;
  final String? question_description;
  final List<String?> tag;
  final Map<String, String> answer;
  final int question_point;
  final String correct_answer;
  const QuestionTemplateView({
    super.key,
    required this.question,
    this.question_description,
    required this.tag,
    required this.answer,
    required this.question_point,
    required this.correct_answer,
  });
  @override
  ConsumerState<QuestionTemplateView> createState() => _QuestionTemplateView();
}

class _QuestionTemplateView extends ConsumerState<QuestionTemplateView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: LinearProgressIndicator(value: 0.1),
        ),
        SizedBox(height: 32.0),
        Text(widget.question, style: TextStyle().copyWith(fontSize: 24.0)),
        SizedBox(height: 16),
        Text(widget.question_description ?? '暂无题目描述'),
        SizedBox(height: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.answer.entries.map((entry) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Text('${entry.key}, ${entry.value}'),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
