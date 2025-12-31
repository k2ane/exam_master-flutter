import 'package:flutter/material.dart';

Future<void> showMyDialog(
  BuildContext context,
  String dialogTitle,
  Widget widget,
) async {
  return showDialog<void>(
    // barrierColor: Colors.black.withAlpha(210),
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(dialogTitle),
        content: SingleChildScrollView(child: widget),
        actions: <Widget>[
          TextButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(child: const Text('验证'), onPressed: () => {}),
        ],
      );
    },
  );
}
