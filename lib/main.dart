import 'package:exam_master_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  // 消除在浏览器地址栏中显示#
  usePathUrlStrategy();
  // 1. 必须最先调用，确保 Flutter 引擎初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 2. 🔥 核心：开启“全面屏”模式 (Edge-to-Edge)
  // 这一步告诉 Android：“把我的 App 铺满整个屏幕，连底部导航栏后面也要铺”
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // 3. 🔥 核心：设置状态栏和导航栏样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // --- 顶部状态栏 ---
      statusBarColor: Colors.transparent, // 透明背景
      statusBarIconBrightness: Brightness.dark, // 黑色图标 (因为你的背景是浅粉色)
    ),
  );
  runApp(const ProviderScope(child: ExamApp()));
}

class ExamApp extends ConsumerWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightColorSchema = ColorScheme.fromSeed(
      seedColor: Colors.green, // 🌱 你的种子颜色
      brightness: Brightness.light,
    );
    final darkColorSchema = ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    );
    final goRouter = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Bondex 训练场',
      routerConfig: goRouter,
      themeMode: ThemeMode.system,
      // Material 3 统一主题
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorSchema,
        scaffoldBackgroundColor: lightColorSchema.surfaceContainerHigh,
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorSchema.surfaceContainerHigh,
        ),
      ),
      //深色主题配置
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorSchema,
        scaffoldBackgroundColor: darkColorSchema.surfaceContainerHigh,
        appBarTheme: AppBarTheme(
          backgroundColor: darkColorSchema.surfaceContainerHigh,
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
