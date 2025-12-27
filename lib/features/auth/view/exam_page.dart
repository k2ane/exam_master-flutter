import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: Text('竞技场'),
          actions: [
            IconButton(
              onPressed: _onRefresh,
              icon: Icon(Icons.refresh),
              tooltip: "刷新",
            ),
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.help),
              tooltip: "帮助",
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 20,
          separatorBuilder: (c, i) => const SizedBox(height: 16), // 列表间距
          itemBuilder: (context, index) {
            return Card(
              elevation: 4, // 阴影深度
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "2024年海关模拟考卷 - 0$index",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "进行中",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "这是一个很长的描述文本，用来测试卡片的高度自适应效果。如果文字很多，卡片应该会自动变高。",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 12),
                    const LinearProgressIndicator(value: 0.7), // 进度条
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
    // 手机视图
    return Scaffold(
      appBar: AppBar(
        title: Text('竞技场'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.help),
            tooltip: "帮助",
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 20,
          separatorBuilder: (c, i) => const SizedBox(height: 16), // 列表间距
          itemBuilder: (context, index) {
            return Card(
              elevation: 4, // 阴影深度
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "2024年海关模拟考卷 - 0$index",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "进行中",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "这是一个很长的描述文本，用来测试卡片的高度自适应效果。如果文字很多，卡片应该会自动变高。",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 12),
                    const LinearProgressIndicator(value: 0.7), // 进度条
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<void> _onRefresh() async {
  await Future.delayed(Duration(seconds: 2));
  print('yout are requested');
}
