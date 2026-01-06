import 'dart:async';

import 'package:exam_master_flutter/views/widgets/appcontainer_widget.dart';
import 'package:exam_master_flutter/views/widgets/function_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ArenaView extends ConsumerWidget {
  const ArenaView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AppcontainerWidget(
      viewTitle: '训练场',
      viewSubTitle: '请选择训练模块',
      children: [
        FunctionCardWidget(ontap: () => context.go('/sequential')),
        FunctionCardWidget(
          ontap: () => {
            EasyLoading.instance
              ..maskType = EasyLoadingMaskType.black
              ..loadingStyle = isDark
                  ? EasyLoadingStyle.dark
                  : EasyLoadingStyle.light,
            EasyLoading.show(
              status: '请稍后...',
              // dismissOnTap: true,
              indicator: CircularProgressIndicator(),
            ),
            // 设置倒计时5秒
            Timer(Duration(seconds: 5), () {
              debugPrint('退出加载状态');
              EasyLoading.dismiss();
            }),
          },
        ),
        FunctionCardWidget(),
        FunctionCardWidget(),
        FunctionCardWidget(),
        FunctionCardWidget(),
        FunctionCardWidget(),
        FunctionCardWidget(),
        FunctionCardWidget(),
        FunctionCardWidget(),
        FunctionCardWidget(),
      ],
    );
  }
}
