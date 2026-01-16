import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinearProgressIndicatorWidget extends ConsumerWidget {
  final double progress; // 当前进度 (0.0 到 1.0)

  const LinearProgressIndicatorWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TweenAnimationBuilder<double>(
      // 1. 设置动画的目标值 (end)
      // begin 只需要在第一次构建时起作用，通常设为 0 或者不设
      tween: Tween<double>(begin: 0, end: progress),

      // 2. 设置动画时长
      duration: const Duration(milliseconds: 300),

      // 3. 动画曲线 (可选，easeOut 让结尾减速更自然)
      curve: Curves.easeOut,

      // 4. 构建器：value 是当前动画计算出的中间值
      builder: (context, value, child) {
        return LinearProgressIndicator(
          value: value, // 🔥 这里用动画生成的 value，而不是原始的 progress
        );
      },
    );
  }
}
