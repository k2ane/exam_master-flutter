import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExampleView extends ConsumerStatefulWidget {
  final String title;
  final String content;
  const ExampleView({super.key, required this.title, required this.content});
  @override
  ConsumerState<ExampleView> createState() => _ExampleView();
}

class _ExampleView extends ConsumerState<ExampleView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final bool shouldLeave = await _showExitDialog(context) ?? false;
        if (shouldLeave && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title), centerTitle: false),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(widget.content),
        ),
      ),
    );
  }
}

Future<bool?> _showExitDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("退出确认"),
        content: const Text("退出将无法保存当前进度，确定要离开吗？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // 返回 false
            child: const Text("取消"),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true), // 返回 true
            child: const Text("确定退出"),
          ),
        ],
      );
    },
  );
}
