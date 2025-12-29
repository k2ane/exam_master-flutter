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
      body: Text('这是 排名 页面'),
    );
  }
}
