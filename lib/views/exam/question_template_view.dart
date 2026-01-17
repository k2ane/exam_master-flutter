import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionTemplateView extends ConsumerStatefulWidget {
  final String type;
  final String question;
  final List<String> options;
  final String answer;
  final String? explanation;
  const QuestionTemplateView({
    super.key,
    required this.type,
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
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
        Text(widget.question, style: TextStyle().copyWith(fontSize: 24.0)),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.options.asMap().entries.map((entry) {
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
                  child: Text(entry.value),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '答案解析',
                  style: TextStyle().copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(200),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.explanation ?? '暂无题目描述',
                  style: TextStyle().copyWith(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
