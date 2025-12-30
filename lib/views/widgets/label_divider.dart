import 'package:flutter/material.dart';

class LabelDivider extends StatelessWidget {
  final String label;
  final Color textColor;
  final bool isSameColor;
  const LabelDivider({
    super.key,
    required this.label,
    required this.textColor,
    this.isSameColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: isSameColor
                  ? Theme.of(context).scaffoldBackgroundColor
                  : textColor,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0), // 字和线的间距
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: isSameColor
                  ? Theme.of(context).scaffoldBackgroundColor
                  : textColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
