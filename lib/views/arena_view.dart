import 'package:exam_master_flutter/views/widgets/appbar_widget.dart';
import 'package:exam_master_flutter/views/widgets/function_card_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArenaView extends ConsumerWidget {
  const ArenaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppbarWidget(
          viewTitle: '训练场',
          viewSubTitle: '选择你的训练模块',
          showBackButton: false,
        ),
        FunctionCardWidget(),
        FunctionCardWidget(),
        FunctionCardWidget(),
      ],
    );
  }
}
