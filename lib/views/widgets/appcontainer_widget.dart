import 'package:flutter/material.dart';
import 'package:exam_master_flutter/views/widgets/appbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppcontainerWidget extends ConsumerWidget {
  final String viewTitle;
  final String viewSubTitle;
  final Widget child;
  final bool? showBackButton;
  const AppcontainerWidget({
    super.key,
    required this.viewTitle,
    required this.viewSubTitle,
    required this.child,
    this.showBackButton = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Scrollbar(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              AppbarWidget(
                viewTitle: viewTitle,
                viewSubTitle: viewSubTitle,
                showBackButton: showBackButton,
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
