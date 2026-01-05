import 'package:flutter/material.dart';
import 'package:exam_master_flutter/views/widgets/appbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppcontainerWidget extends ConsumerStatefulWidget {
  final bool? isMainView;
  final String? viewTitle;
  final String? viewSubTitle;
  final Widget? child;
  final bool? showBackButton;
  final List<Widget>? navigationWidgets;
  final List<Widget>? navigationDestination;
  const AppcontainerWidget({
    super.key,
    this.viewTitle,
    this.isMainView = false,
    this.viewSubTitle,
    this.child,
    this.showBackButton = false,
    this.navigationWidgets,
    this.navigationDestination,
  });
  @override
  ConsumerState<AppcontainerWidget> createState() => _AppContainerState();
}

class _AppContainerState extends ConsumerState<AppcontainerWidget> {
  int currentSelectIndex = 0;
  bool is_scrolled = false;
  @override
  Widget build(BuildContext context) {
    return widget.isMainView!
        ? GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Scrollbar(
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [widget.navigationWidgets![currentSelectIndex]],
                ),
              ),

              bottomNavigationBar: NavigationBar(
                selectedIndex: currentSelectIndex,
                onDestinationSelected: (value) => setState(() {
                  currentSelectIndex = value;
                }),
                destinations: widget.navigationDestination!,
              ),
            ),
          )
        : GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh, // 背景色
                      border: Border(
                        bottom: BorderSide(
                          // 使用 outlineVariant (淡灰色) 作为分割线
                          color: is_scrolled
                              ? Theme.of(context).colorScheme.outlineVariant
                              : Colors.transparent,
                          width: 1.0, // 线条粗细
                        ),
                      ),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    height: 167,
                    child: AppbarWidget(
                      viewTitle: widget.viewTitle,
                      viewSubTitle: widget.viewSubTitle,
                      showBackButton: widget.showBackButton,
                    ),
                  ),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollNotification) {
                          // 获取滚动距离
                          final double offset = notification.metrics.pixels;
                          final bool shouldBeScrolled = offset > 0;
                          if (is_scrolled != shouldBeScrolled) {
                            setState(() {
                              is_scrolled = shouldBeScrolled;
                            });
                          }
                        }
                        return false;
                      },
                      child: ListView(
                        padding: EdgeInsets.all(16.0),
                        children: [widget.child!],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
