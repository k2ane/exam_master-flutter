import 'package:exam_master_flutter/providers/auth_state_provider.dart';
import 'package:exam_master_flutter/views/arena_view.dart';
import 'package:exam_master_flutter/views/dashboard_view.dart';
import 'package:exam_master_flutter/views/exam/exam_example_demo_view.dart';
import 'package:exam_master_flutter/views/exam/sequential_exam_view.dart';
import 'package:exam_master_flutter/views/auth/login_view.dart';
import 'package:exam_master_flutter/views/gift_view.dart';
import 'package:exam_master_flutter/views/leader_board_view.dart';
import 'package:exam_master_flutter/views/license_view.dart';
import 'package:exam_master_flutter/views/profile_view.dart';
import 'package:exam_master_flutter/views/splash/splash_view.dart';
import 'package:exam_master_flutter/views/widgets/desktop_scaffold_with_navigationbar.dart';
import 'package:exam_master_flutter/views/widgets/responsive_layout.dart';
import 'package:exam_master_flutter/views/widgets/phone_scaffold_with_navigationbar.dart';
import 'package:exam_master_flutter/views/widgets/settings_template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = AuthListener(ref);
  return GoRouter(
    debugLogDiagnostics: true, // 调试模式下显示路由状态
    initialLocation: '/splash', // 默认路由页面
    refreshListenable: authNotifier,
    redirect: (context, state) {
      // 获取全局登陆状态
      final authState = ref.read(authStateProvider);
      if (authState.isLoading) return null;
      if (authState.hasError) return '/login';
      final bool isLoggedIn = authState.value == true;
      final bool isLogginIn = state.matchedLocation == '/login';
      final bool isInSplash = state.matchedLocation == '/splash';
      if (!isLoggedIn && !isLogginIn && !isInSplash) {
        return '/login';
      }

      if (isLogginIn && isLoggedIn) {
        return '/';
      }

      if (isInSplash) {
        return null;
      }
      return null;
    },
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
                path: '/gift',
                builder: (context, state) => const GiftView(),
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
                    path: '/settings',
                    builder: (context, state) =>
                        const SettingsTemplate(pageTitle: '设置'),
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
      GoRoute(path: '/splash', builder: (context, state) => const SplashView()),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: '/exam',
        builder: (context, state) => const ExamExampleDemoView(),
      ),
    ],
  );
});

class AuthListener extends ChangeNotifier {
  AuthListener(Ref ref) {
    // 在这里使用 ref.listen 监听 authStateProvider
    // 每当 authStateProvider 状态发生变化时，调用 notifyListeners()
    ref.listen<AsyncValue<bool>>(authStateProvider, (previous, next) {
      notifyListeners();
    });
  }
}
