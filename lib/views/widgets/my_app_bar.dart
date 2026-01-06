import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});
  @override
  ConsumerState<MyAppBar> createState() => _MyAppBar();
  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class _MyAppBar extends ConsumerState<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      // color: Theme.of(context).colorScheme.surfaceContainerHigh,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top, // 🔥 避开状态栏
        left: 16,
        right: 16,
        bottom: 16,
      ),
      height: 120, // 总高度
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton.filled(icon: Icon(Icons.arrow_back), onPressed: () {}),
          SizedBox(width: 8),
          Text(
            "AppBar",
            style: TextStyle().copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
    );
  }
}
