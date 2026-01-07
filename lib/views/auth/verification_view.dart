import 'dart:async';
import 'package:flutter/material.dart';
import 'package:exam_master_flutter/providers/global_email_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationView extends ConsumerStatefulWidget {
  const VerificationView({super.key});
  @override
  ConsumerState<VerificationView> createState() => _VerificationView();
}

class _VerificationView extends ConsumerState<VerificationView> {
  int downCount = 60;
  bool isCount = false;
  bool fristClicked = true;
  Timer? _timer;

  final TextEditingController _passcodeController = TextEditingController();

  Future<void> startDownCount() async {
    // 取消旧的计时器
    _timer?.cancel();
    debugPrint('进入函数');
    // 检查倒计时是否已经启动
    if (downCount == 0) {
      setState(() {
        isCount = false;
      });
      EasyLoading.dismiss();
    } else {
      // 重置倒计时数
      downCount = 60;
      setState(() {
        isCount = true;
        fristClicked = false;
      });
      EasyLoading.dismiss();
      // 创建倒计时
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        debugPrint('进入函数');
        // 检查downCount是否为0， 如果为0则停止计时
        if (downCount == 0) {
          // 设置状态
          debugPrint('设置状态为未在计时');
          setState(() {
            isCount = false;
          });
          EasyLoading.dismiss();
          // 跳出循环
          // 取消计时器
          timer.cancel();
        } else {
          debugPrint('计时数值为：$downCount');
          setState(() {
            downCount--;
          });
        }
      });
    }
  }

  @override
  dispose() {
    _passcodeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
