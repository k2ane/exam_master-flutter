import 'package:exam_master_flutter/core/widgets/arena_card.dart';
import 'package:flutter/material.dart';

class ArenaPage extends StatelessWidget {
  final bool isShowButton;
  const ArenaPage({super.key, this.isShowButton = true});

  @override
  Widget build(BuildContext context) {
    // bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '竞技场',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: isShowButton
            ? [
                IconButton(
                  onPressed: () => _showRedeemCodeDialog(context: context),
                  icon: Icon(Icons.add_circle),
                ),
              ]
            : [],
      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text('欢迎来到竞技场, Kane'),

            Divider(height: 1, thickness: 1),
            SizedBox(height: 20),
            ArenaCard(
              cardIcon: Icons.description_outlined,
              cardTitle: "进出口货物申报管理规定",
              cardDescription: "在这里你可以学到关于进出口货物申报的一切基本知识",
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ArenaCard(
                    cardIcon: Icons.quiz_outlined,
                    cardTitle: "考试",
                    cardDescription: "考试模块",
                  ),
                ),
                Expanded(
                  child: ArenaCard(
                    cardIcon: Icons.assistant_outlined,
                    cardTitle: "AI分析",
                    cardDescription: "在这里你可以学到关于进出口货物申报的一切基本知识",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showRedeemCodeDialog({required BuildContext context}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('激活题库'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "兑换码",
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('兑换'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
