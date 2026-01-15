import 'package:exam_master_flutter/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class UserInfoCardWidget extends ConsumerWidget {
  const UserInfoCardWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    return Card(
      margin: EdgeInsets.all(0),
      child: userInfo.when(
        data: (data) => ListTile(
          contentPadding: EdgeInsets.only(top: 8, left: 16, right: 16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: SvgPicture.network(
                      'https://api.dicebear.com/9.x/adventurer/svg?seed=Sara',
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    data.name.length > 10
                        ? '${data.name.replaceRange(10, null, '')}...'
                        : data.name,
                    style: TextStyle().copyWith(
                      fontSize: 32,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chip(
                  //   avatar: Icon(Icons.public_outlined),
                  //   label: Text(
                  //     data.id,
                  //     style: TextStyle().copyWith(fontSize: 12),
                  //   ),
                  // ),
                  // SizedBox(width: 4),
                  Chip(
                    avatar: Icon(Icons.groups_outlined),
                    label: Text(
                      data.role == '1' ? '管理员' : '学员',
                      style: TextStyle().copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        error: (Object error, StackTrace stackTrace) {
          return Text('加载失败');
        },
        loading: () {
          return Text('加载中...');
        },
      ),
    );
  }
}
