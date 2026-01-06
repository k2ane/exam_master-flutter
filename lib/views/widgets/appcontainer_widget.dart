import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppcontainerWidget extends ConsumerStatefulWidget {
  final String viewTitle;
  final String viewSubTitle;
  final bool showAction;
  final List<Widget>? actions;
  final List<Widget> children;
  const AppcontainerWidget({
    super.key,
    required this.viewTitle,
    required this.viewSubTitle,
    required this.children,
    this.actions,
    this.showAction = false,
  });
  @override
  ConsumerState<AppcontainerWidget> createState() => _AppContainerState();
}

class _AppContainerState extends ConsumerState<AppcontainerWidget> {
  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(16),
        titleSpacing: 0,
        toolbarHeight: 104,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.viewTitle,
                style: TextStyle().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: colorSchema.onSurface,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.viewSubTitle,
                style: TextStyle().copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: colorSchema.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        actions: widget.showAction == false ? [] : widget.actions,
        actionsIconTheme: IconThemeData(color: colorSchema.onPrimary),
      ),
      body: ListView(padding: EdgeInsets.all(16), children: widget.children),
    );
  }
}
