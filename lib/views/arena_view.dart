import 'package:exam_master_flutter/views/example_view.dart';
import 'package:exam_master_flutter/views/widgets/arena_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArenaView extends ConsumerWidget {
  const ArenaView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('试炼场'),
        centerTitle: false,
        actionsPadding: EdgeInsets.only(right: 16),
        actions: [
          IconButton.filled(
            color: Theme.of(context).colorScheme.onPrimary,
            tooltip: '添加功能',
            onPressed: () => {},
            icon: Icon(
              Icons.add,
              // color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double totalWidth = constraints.maxWidth;
          final double spacing = 16;
          int columns = totalWidth > 2000
              ? 6
              : (totalWidth > 1500
                    ? 5
                    : (totalWidth > 1000
                          ? 4
                          : (totalWidth > 800
                                ? 3
                                : (totalWidth > 429 ? 2 : 1))));
          final double padding = 16 * 2; // 左右两边各16
          final double cardWidth =
              (totalWidth - padding - (spacing * (columns - 1))) / columns;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Wrap(
              spacing: spacing, // 水平间距
              runSpacing: spacing, // 垂直间距
              children: [
                // 5. 强制给每个卡片指定计算好的宽度
                SizedBox(
                  width: cardWidth,
                  child: ArenaCardWidget(
                    action: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExampleView(title: '基础题库', content: '基础题库内页...'),
                      ),
                    ),
                    cardTitle: '基础题库',
                    subTitle: '简单',
                    iamgeUrl: 'Basic_Question_Bank.jpg',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: ArenaCardWidget(
                    action: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExampleView(title: '进阶题库', content: '进阶题库内页...'),
                      ),
                    ),
                    cardTitle: '进阶题库',
                    subTitle: '中等',
                    iamgeUrl: 'Advance_Question_Bank.jpg',
                    badgeColor: isDark ? Colors.yellow : Colors.yellow.shade900,
                    textColor: isDark
                        ? Theme.of(context).colorScheme.surfaceContainer
                        : Colors.white,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: ArenaCardWidget(
                    action: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExampleView(title: '模拟报关', content: '模拟报关内页...'),
                      ),
                    ),
                    cardTitle: '模拟报关',
                    subTitle: '困难',
                    iamgeUrl: 'Sim_Customs.jpg',
                    badgeColor: Colors.red,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: ArenaCardWidget(
                    action: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExampleView(title: '错题本', content: '错题本内页...'),
                      ),
                    ),
                    cardTitle: '错题本',
                    subTitle: '工具',
                    iamgeUrl: 'Error_Notebook.jpg',
                    badgeColor: Colors.blue,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
