import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyNavigationBar extends ConsumerStatefulWidget {
  const MyNavigationBar({super.key});
  @override
  ConsumerState<MyNavigationBar> createState() => _MyNavigationBar();
}

class _MyNavigationBar extends ConsumerState<MyNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIcon(Icons.home, true, context),
            _buildIcon(Icons.search, false, context),
            _buildIcon(Icons.person, false, context),
            _buildIcon(Icons.person, false, context),
          ],
        ),
      ),
    );
  }
}

Widget _buildIcon(IconData icon, bool isSelected, BuildContext context) {
  return TextButton(
    onPressed: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[700],
          ),
          Text(
            '功能',
            style: TextStyle().copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[700],
            ),
          ),
        ],
      ),
    ),
  );
}
