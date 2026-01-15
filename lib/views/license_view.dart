import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LicenseView extends ConsumerWidget {
  const LicenseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('许可证')),
      body: Text('版权页面'),
    );
  }
}
