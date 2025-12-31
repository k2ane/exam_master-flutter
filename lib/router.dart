import 'package:exam_master_flutter/providers/login_state_provider.dart';
import 'package:exam_master_flutter/views/widgets/responsive_layout.dart';
import 'package:exam_master_flutter/providers/auth_provider.dart';
import 'package:exam_master_flutter/views/desktop/d_navigation_page.dart';
import 'package:exam_master_flutter/views/shared/login_page.dart';
import 'package:exam_master_flutter/views/shared/me_page.dart';
import 'package:exam_master_flutter/views/mobile/m_navigation_page.dart';
import 'package:exam_master_flutter/views/widgets/otp_widget.dart';
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
      final email = ref.read(loginEmailProvider);
      // 🔒 没登录，且没在登录相关页面 -> 踢去登录页
      if (!isLoggedIn && !isGoingToLogin) {
        return '/login';
      }

      // 🔒 OTP 页面专属守卫
      if (state.matchedLocation == '/login/otp') {
        // 检查身上有没有带信物 (extra)
        if (email == "" || email.isEmpty) {
          // 没带信物？说明是直接偷渡过来的，踢回登录页重填
          return '/login';
        }
      }

      // 🔓 已登录，但还在登录页 -> 踢回首页
      if (isLoggedIn && isGoingToLogin) {
        return '/home';
      }

      // 不需要重定向
      return null;
    },

    // 3. 定义路由表
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(path: '/otp', builder: (context, state) => const OtpWidget()),
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
    ],
  );
});
