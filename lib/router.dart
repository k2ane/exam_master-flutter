import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/providers/global_email_provider.dart';
import 'package:exam_master_flutter/utils/app_transitions.dart';
import 'package:exam_master_flutter/views/example_view.dart';
import 'package:exam_master_flutter/views/auth/login_view.dart';
import 'package:exam_master_flutter/views/auth/verification_view.dart';
import 'package:exam_master_flutter/views/widgets/desktop_layout.dart';
import 'package:exam_master_flutter/views/widgets/phone_layout.dart';
import 'package:exam_master_flutter/views/widgets/responsive_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    debugLogDiagnostics: true, // 调试模式下显示路由状态
    initialLocation: '/', // 默认路由页面
    // 重定向, 每次路由都会经过这里
    redirect: (context, state) async {
      //检查登录状态
      if (authState.isLoading || authState.hasError) {
        return null;
      }
      final isLoggedIn = authState.valueOrNull ?? false;
      // 检测用户是否在登录页面
      final isGoingToLogin = state.matchedLocation.startsWith('/login');
      // 检测是否有登录，默认为未登录
      if (!isLoggedIn && !isGoingToLogin) {
        return '/login';
      }

      if (isLoggedIn && isGoingToLogin) {
        return '/';
      }

      if (state.matchedLocation.startsWith('/login/verification') &&
          ref.read(globalEmailProvider).isEmpty) {
        return '/login';
      }

      return null;
    },

    // 3. 定义路由表
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            AppTransitions.slideUp(state, const LoginView()),
        routes: [
          GoRoute(
            path: '/verification',
            builder: (context, state) => const VerificationView(),
          ),
        ],
      ),

      GoRoute(
        path: '/',
        pageBuilder: (context, state) => AppTransitions.slideUp(
          state,
          ResponsiveLayout(phone: PhoneLayout(), desktop: DesktopLayout()),
        ),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ExampleView(
          viewTitle: 'Profile',
          viewDescription: 'This is Profile view.',
        ),
      ),
    ],
  );
});
