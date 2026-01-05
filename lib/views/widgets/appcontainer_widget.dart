import 'package:flutter/material.dart';
import 'package:exam_master_flutter/views/widgets/appbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppcontainerWidget extends ConsumerStatefulWidget {
  final bool? isMainView;
  final String viewTitle;
  final String viewSubTitle;
  final Widget? child;
  final bool? showBackButton;
  final List<Widget>? navigationWidgets;
  final List<Widget>? navigationDestination;
  const AppcontainerWidget({
    super.key,
    required this.viewTitle,
    this.isMainView,
    required this.viewSubTitle,
    this.child,
    this.showBackButton,
    this.navigationWidgets,
    this.navigationDestination,
  });
  @override
  ConsumerState<AppcontainerWidget> createState() => _AppContainerState();
}

class _AppContainerState extends ConsumerState<AppcontainerWidget> {
  int currentSelectIndex = 0;
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
              body: Scrollbar(
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    AppbarWidget(
                      viewTitle: widget.viewTitle,
                      viewSubTitle: widget.viewSubTitle,
                      showBackButton: widget.showBackButton,
                    ),
                    widget.child!,
                  ],
                ),
              ),
            ),
          );
  }
}
