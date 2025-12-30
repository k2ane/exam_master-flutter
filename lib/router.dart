// lib/router.dart
import 'package:exam_master_flutter/core/widgets/responsive_layout.dart';
import 'package:exam_master_flutter/features/auth/logic/auth_controller.dart';
import 'package:exam_master_flutter/features/auth/view/desktop/d_navigation_page.dart';
import 'package:exam_master_flutter/features/auth/view/login_page.dart';
import 'package:exam_master_flutter/features/auth/view/me_page.dart';
import 'package:exam_master_flutter/features/auth/view/mobile/m_navigation_page.dart';
import 'package:exam_master_flutter/features/auth/view/otp_page.dart';
import 'package:exam_master_flutter/main.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // 1. 监听登录状态变化 (这句是核心！一旦登录状态变了，路由会自动刷新)
  final bool isLoggedIn = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/home', // 默认想去首页
    // 2. 核心鉴权逻辑：每次路由跳转前都会经过这里
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation.startsWith('/login');

      // 🔒 情况 A：没登录，且没在登录相关页面 -> 踢去登录页
      if (!isLoggedIn && !isGoingToLogin) {
        return '/login';
      }

      // 2. ✅ 新增：OTP 页面专属守卫
      if (state.matchedLocation == '/login/otp') {
        // 检查身上有没有带信物 (extra)
        if (state.extra == null) {
          // 没带信物？说明是直接偷渡过来的，踢回登录页重填
          return '/login';
        }
      }

      // 🔓 情况 B：已登录，但还在登录页 -> 踢回首页
      if (isLoggedIn && isGoingToLogin) {
        return '/home';
      }

      // 不需要重定向
      return null;
    },

    // 3. 定义路由表 (替换掉你原来的 routes Map)
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: '/otp',
            builder: (context, state) {
              final email = state.extra as String?;
              return OtpPage(email: email ?? "");
            },
          ),
        ],
      ),

      GoRoute(
        path: '/home',
        builder: (context, state) => const ResponsiveLayout(
          mobile: MMainNavigationScaffold(),
          desktop: DMainNavigationScaffold(),
        ),
      ),
      GoRoute(path: '/me', builder: (context, state) => const MePage()),
      GoRoute(
        path: '/detail',
        builder: (context, state) => const DetailsScreen(),
      ),
    ],
  );
});
