import 'package:flutter/material.dart';

Future<dynamic> showArenaPopDialog(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('About Title'),
        content: Text('content...'),
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
