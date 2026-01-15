import 'package:flutter/material.dart';

Future<dynamic> showArenaPopDialog(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('测试弹窗'),
        content: Text('弹窗内容...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('确定'),
          ),
        ],
      );
    },
  );
}
