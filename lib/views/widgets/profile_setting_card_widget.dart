import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSettingCardWidget extends ConsumerWidget {
  final String title;
  final String description;
  final Icon? icon;
  final Color? iconBackground;
  final Color? iconForeground;
  final void Function()? ontap;
  const ProfileSettingCardWidget({
    super.key,
    required this.title,
    this.icon,
    this.iconBackground,
    this.iconForeground,
    required this.description,
    this.ontap,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: ontap ?? () {},
        leading: CircleAvatar(
          backgroundColor: iconBackground ?? Colors.purple,
          foregroundColor: iconForeground ?? Colors.white,
          child: icon ?? Icon(Icons.timeline_outlined),
        ),
        title: Text(title),
        subtitle: Text(description, style: TextStyle().copyWith(fontSize: 12)),
        trailing: Icon(Icons.chevron_right_outlined),
      ),
    );
  }
}

Future<dynamic> showlogoutDialog(
  BuildContext context,
  void Function()? ontap,
) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('确定要退出吗？'),
        content: Text('退出登录状态后需要重新登录才能访问此应用'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: Text('取消'),
          ),
          FilledButton(onPressed: ontap ?? () => {}, child: Text('确定')),
        ],
      );
    },
  );
}
