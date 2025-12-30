import 'package:exam_master_flutter/views/widgets/label_divider.dart';
import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.help_outline)),
        ],
      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero, // 减少内边距
              leading: CircleAvatar(
                // 用 CircleAvatar 更好看
                radius: 30,
                child: Text('K', style: TextStyle(fontSize: 30)),
              ),
              title: Text(
                'Kane',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text('k2anefs@gmail.com'),
            ),
            SizedBox(height: 20),
            Material(
              clipBehavior: Clip.antiAlias,
              // color: isDark ? Colors.black26 : Colors.white,
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.assignment_ind,
                    iconColor: Colors.red,
                    circleColor: Colors.white.withAlpha(180),
                    title: "个性化设置",
                    subtitle: "姓名，邮箱，部门， 电话",
                  ),
                  Divider(
                    height: 3,
                    thickness: 3,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  _buildSettingsTile(
                    icon: Icons.assignment_ind,
                    iconColor: Colors.green,
                    circleColor: Colors.white.withAlpha(180),
                    title: "趋势",
                    subtitle: "进度，统计",
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            LabelDivider(
              textColor: Colors.redAccent,
              label: "危险区，请谨慎操作",
              isSameColor: false,
            ),
            SizedBox(height: 30),
            Material(
              clipBehavior: Clip.antiAlias,
              // color: isDark ? Colors.black26 : Colors.white,
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.assignment_ind,
                    iconColor: Colors.red,
                    circleColor: Colors.white.withAlpha(180),
                    title: "注销",
                    subtitle: "不再使用此账户",
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  '©2025 Designed by kane on earth :)',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSettingsTile({
  required IconData icon,
  required Color iconColor,
  required Color circleColor,
  required String title,
  required String subtitle,
}) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: iconColor,
      child: Icon(icon, color: circleColor),
    ), // 图标颜色深一点更有质感
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w300)),
    subtitle: Text(
      subtitle,
      style: TextStyle(color: Colors.grey[500], fontSize: 12),
    ),
    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[500]),
    onTap: () {},
  );
}
