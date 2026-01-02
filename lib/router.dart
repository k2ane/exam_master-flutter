import 'package:exam_master_flutter/views/example_view.dart';
import 'package:exam_master_flutter/views/login_view.dart';
import 'package:exam_master_flutter/views/verification_view.dart';
import 'package:exam_master_flutter/views/widgets/desktop_layout.dart';
import 'package:exam_master_flutter/views/widgets/phone_layout.dart';
import 'package:exam_master_flutter/views/widgets/responsive_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login', // 默认路由页面
    // 重定向, 每次路由都会经过这里
    redirect: (context, state) {
      return null;
    },

    // 3. 定义路由表
    routes: [
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
        path: '/',
        builder: (context, state) =>
            ResponsiveLayout(phone: PhoneLayout(), desktop: DesktopLayout()),
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
