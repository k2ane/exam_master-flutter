import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionAnswer extends ConsumerStatefulWidget {
  const QuestionAnswer({super.key});
  @override
  ConsumerState<QuestionAnswer> createState() => _QuestionAnswer();
}

class _QuestionAnswer extends ConsumerState<QuestionAnswer> {
  final List<String> answers = [
    "A. 7天",
    "B. 10天",
    "C. 14天",
    "D. 15天",
    "E. 20天",
    "F. 30天",
  ];

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: answers.asMap().entries.map((entry) {
        int idx = entry.key;
        String text = entry.value;
        bool isSelected = selectedIndex == idx;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              clipBehavior: Clip.antiAlias,
              style: FilledButton.styleFrom(
                backgroundColor: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withAlpha(20),
              ),
              onPressed: () => {
                setState(() {
                  selectedIndex = idx;
                }),
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  top: 14,
                  bottom: 14,
                  right: 8,
                ),
                child: Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    text,
                    style: TextStyle().copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
