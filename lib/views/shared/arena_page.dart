import 'package:exam_master_flutter/views/widgets/arena_card.dart';
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
                  icon: Icon(Icons.add_circle_outline),
                ),
              ]
            : [],
      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('欢迎来到竞技场'),
                Text('Kane', style: TextStyle(fontSize: 24, fontWeight: .w800)),
              ],
            ),
            SizedBox(height: 20),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 20),
            ArenaCard(
              showProgress: true,
              paramArgs: {"title": "进出口货物申报管理规定"},
              pushUrl: '/detail',
              cardBadge: "基础",
              badgeColor: Colors.green,
              cardIcon: Icons.description_outlined,
              cardTitle: "进出口货物申报管理规定",
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ArenaCard(
                    paramArgs: {"title": "考试"},
                    pushUrl: '/detail',
                    cardBadge: "试炼",
                    badgeColor: Colors.teal,
                    cardIcon: Icons.edit_outlined,
                    cardTitle: "考试",
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ArenaCard(
                    paramArgs: {"title": "真题"},
                    pushUrl: '/detail',
                    cardBadge: "困难",
                    badgeColor: Colors.orange,
                    cardIcon: Icons.panorama_photosphere_outlined,
                    cardTitle: "真题",
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ArenaCard(
                    paramArgs: {"title": "模拟报关"},
                    pushUrl: '/detail',
                    cardBadge: "工具",
                    badgeColor: Colors.purple,
                    cardIcon: Icons.public_outlined,
                    cardTitle: "模拟报关",
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ArenaCard(
                    paramArgs: {"title": "AI助手"},
                    pushUrl: '/detail',
                    cardBadge: "工具",
                    badgeColor: Colors.purple,
                    cardIcon: Icons.auto_awesome_outlined,
                    cardTitle: "AI助手",
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
