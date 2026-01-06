import 'package:exam_master_flutter/views/example_view.dart';
import 'package:exam_master_flutter/views/widgets/my_app_bar.dart';
import 'package:exam_master_flutter/views/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneLayout extends ConsumerStatefulWidget {
  const PhoneLayout({super.key});
  @override
  ConsumerState<PhoneLayout> createState() => _PhoneLayout();
}

class _PhoneLayout extends ConsumerState<PhoneLayout> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: MyAppBar(),
      body: [
        ExampleView(viewTitle: '页面1', viewDescription: '页面1描述'),
      ][selectedIndex],
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}
