import 'package:exam_master_flutter/views/widgets/arena_card_widget.dart';
import 'package:exam_master_flutter/views/widgets/arena_pop_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArenaView extends ConsumerWidget {
  const ArenaView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('海邦试炼场'),
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
                    action: () => showArenaPopDialog(context),
                    cardTitle: '基础题库',
                    subTitle: '了解基本的关务知识',
                    iamgeUrl: 'Basic_Question_Bank.jpg',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: ArenaCardWidget(
                    cardTitle: '进阶题库',
                    subTitle: '从真实的例子中巩固关务知识',
                    iamgeUrl: 'Advance_Question_Bank.jpg',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: ArenaCardWidget(
                    cardTitle: '模拟报关',
                    subTitle: '模拟报关，熟悉流程',
                    iamgeUrl: 'Sim_Customs.jpg',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: ArenaCardWidget(
                    cardTitle: '错题本',
                    subTitle: '所有答错题目汇集于此',
                    iamgeUrl: 'Error_Notebook.jpg',
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
