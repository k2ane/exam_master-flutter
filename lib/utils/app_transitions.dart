import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransitions {
  // 效果1：淡入淡出 (Fade)
  static CustomTransitionPage fade(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  // 效果2：从下往上弹出 (Modal/Bottom Sheet 效果)
  static CustomTransitionPage slideUp(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // y=1.0 代表底部
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
