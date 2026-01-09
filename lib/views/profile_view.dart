import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});
  @override
  ConsumerState<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人资料'), centerTitle: false),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            margin: EdgeInsets.all(0),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        child: Text(
                          'U',
                          style: TextStyle().copyWith(fontSize: 25),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'User',
                        style: TextStyle().copyWith(
                          fontSize: 32,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(width: 4),
                      Chip(
                        avatar: Icon(Icons.email_outlined),
                        label: Text(
                          'user@email.com',
                          style: TextStyle().copyWith(fontSize: 12),
                        ),
                      ),
                      SizedBox(width: 4),
                      Chip(
                        avatar: Icon(Icons.abc),
                        label: Text(
                          '员工',
                          style: TextStyle().copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Card(
            margin: EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () => context.go('/profile/account'),
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                child: Icon(Icons.account_box_outlined),
              ),
              title: Text('账户管理'),
              subtitle: Text(
                '管理您的账户',
                style: TextStyle().copyWith(fontSize: 12),
              ),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ),
          SizedBox(height: 8),
          Card(
            margin: EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                child: Icon(Icons.timeline_outlined),
              ),
              title: Text('答题统计'),
              subtitle: Text(
                '查看您的所有答题记录',
                style: TextStyle().copyWith(fontSize: 12),
              ),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ),
          SizedBox(height: 8),
          Card(
            margin: EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Icon(Icons.support_agent),
              ),
              title: Text('海邦助手'),
              subtitle: Text(
                '查看您的助手使用情况',
                style: TextStyle().copyWith(fontSize: 12),
              ),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
