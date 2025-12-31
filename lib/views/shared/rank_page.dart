import 'package:flutter/material.dart';

class RankPage extends StatelessWidget {
  const RankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '排名',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.help_outline)),
        ],
      ),
      body: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: 100,
          itemBuilder: (context, index) {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('用户 $index'),
                subtitle: Text('这是第 $index 条数据'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => {debugPrint("你点击了第 $index 条数据的按钮")},
              ),
            );
          },
        ),
      ),
    );
  }
}
