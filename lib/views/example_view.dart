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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [Text(viewTitle), Text(viewDescription)]),
    );
  }
}
