import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/providers/global_email_provider.dart';
import 'package:exam_master_flutter/views/arena_view.dart';
import 'package:exam_master_flutter/views/chat_view.dart';
import 'package:exam_master_flutter/views/dashboard_view.dart';
import 'package:exam_master_flutter/views/exam/sequential_exam_view.dart';
import 'package:exam_master_flutter/views/auth/login_view.dart';
import 'package:exam_master_flutter/views/auth/verification_view.dart';
import 'package:exam_master_flutter/views/leader_board_view.dart';
import 'package:exam_master_flutter/views/license_view.dart';
import 'package:exam_master_flutter/views/profile_view.dart';
import 'package:exam_master_flutter/views/widgets/desktop_scaffold_with_navigationbar.dart';
import 'package:exam_master_flutter/views/widgets/responsive_layout.dart';
import 'package:exam_master_flutter/views/widgets/phone_scaffold_with_navigationbar.dart';
import 'package:exam_master_flutter/views/widgets/settings_template.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authStateProvider);
  return GoRouter(
    debugLogDiagnostics: true, // 调试模式下显示路由状态
    initialLocation: '/', // 默认路由页面
    // 重定向
    // redirect: (context, state) async {
    //   //检查登录状态
    //   if (authState.isLoading || authState.hasError) {
    //     return null;
    //   }
    //   final isLoggedIn = authState.valueOrNull ?? false;
    //   // 检测用户是否在登录页面
    //   final isGoingToLogin = state.matchedLocation.startsWith('/login');
    //   // 检测是否有登录，默认为未登录
    //   if (!isLoggedIn && !isGoingToLogin) {
    //     return '/login';
    //   }

    //   if (isLoggedIn && isGoingToLogin) {
    //     return '/';
    //   }

    //   if (state.matchedLocation.startsWith('/login/verification') &&
    //       ref.read(globalEmailProvider).isEmpty) {
    //     return '/login';
    //   }

    //   return null;
    // },

    // 3. 定义路由表
    routes: [
      // 保留底部导航栏且保留页面状态的路由
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ResponsiveLayout(
            phone: PhoneScaffoldWithNavigationbar(
              navigationShell: navigationShell,
            ),
            desktop: DesktopScaffoldWithNavigationbar(
              navigationShell: navigationShell,
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              // 首页
              GoRoute(
                path: '/',
                builder: (context, state) => const ArenaView(),
                routes: [
                  GoRoute(
                    path: '/sequential',
                    builder: (context, state) => SequentialExamView(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/rank',
                builder: (context, state) => LeaderBoardView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                builder: (context, state) => const ChatView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              // 个人资料页面
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileView(),
                routes: [
                  GoRoute(
                    path: '/account',
                    builder: (context, state) =>
                        const SettingsTemplate(pageTitle: '账户管理'),
                  ),
                  GoRoute(
                    path: '/license',
                    builder: (context, state) => const LicenseView(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // 普通路由
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
        routes: [
          GoRoute(
            path: '/verification',
            builder: (context, state) => const VerificationView(),
          ),
        ],
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardView(),
      ),
    ],
  );
});
