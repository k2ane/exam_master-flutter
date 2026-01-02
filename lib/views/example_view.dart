import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExampleView extends ConsumerWidget {
  final String viewTitle;
  final String viewDescription;
  const ExampleView({
    super.key,
    required this.viewTitle,
    required this.viewDescription,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(viewTitle)),
      body: Text(viewDescription),
    );
  }
}
