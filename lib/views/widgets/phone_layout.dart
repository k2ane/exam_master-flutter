import 'package:exam_master_flutter/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneLayout extends ConsumerWidget {
  const PhoneLayout({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HomeView();
  }
}
