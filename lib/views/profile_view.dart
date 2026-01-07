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
      appBar: AppBar(
        title: Text('个人资料', style: TextStyle(fontSize: 36)),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Text('U', style: TextStyle().copyWith(fontSize: 25)),
                ),
                SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User',
                      style: TextStyle().copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'user@email.com',
                      style: TextStyle().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, thickness: 1),
          ),

          Card(
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
              trailing: Icon(Icons.arrow_right_outlined),
            ),
          ),

          Card(
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
              trailing: Icon(Icons.arrow_right_outlined),
            ),
          ),

          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Icon(Icons.support_agent),
              ),
              title: Text('AI助手积分'),
              subtitle: Text(
                '查看您的AI Agent使用情况',
                style: TextStyle().copyWith(fontSize: 12),
              ),
              trailing: Icon(Icons.arrow_right_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
