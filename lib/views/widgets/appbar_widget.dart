import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppbarWidget extends ConsumerWidget {
  final String viewTitle;
  final String? viewSubTitle;
  final bool? showBackButton;
  final List<Widget>? actions;
  const AppbarWidget({
    super.key,
    required this.viewTitle,
    required this.viewSubTitle,
    this.showBackButton = false,
    this.actions,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 48.0, bottom: 24),
      child: showBackButton != null && showBackButton == false
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewTitle,
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8.0),
                viewSubTitle != null
                    ? Text(
                        viewSubTitle!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withAlpha(200),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            )
          : Row(
              crossAxisAlignment: .start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewTitle,
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    viewSubTitle != null
                        ? Text(viewSubTitle!, style: TextStyle(fontSize: 13))
                        : const SizedBox.shrink(),
                  ],
                ),
                IconButton.filled(
                  tooltip: '返回',
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.chevron_left),
                ),
              ],
            ),
    );
  }
}
