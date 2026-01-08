import 'package:exam_master_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  // 消除在浏览器地址栏中显示#
  usePathUrlStrategy();
  // 引擎初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 全面屏
  // 铺满整个屏幕
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // 设置状态栏和导航栏样式
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
      seedColor: Colors.blue, // 种子颜色
      brightness: Brightness.light,
    );
    final darkColorSchema = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    );
    final goRouter = ref.watch(routerProvider);
    return MaterialApp.router(
      title: '海程问答',
      routerConfig: goRouter,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
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
      locale: const Locale('zh', 'CN'),
      supportedLocales: const [
        Locale('zh', 'CN'), // 中文简体
        // Locale('en', 'US'), // 美国英语
      ],
      localizationsDelegates: const [
        // 负责 Material 组件 (包括 Back 按钮、日期弹窗等)
        GlobalMaterialLocalizations.delegate,
        // 负责 Cupertino 组件 (iOS 风格组件)
        GlobalCupertinoLocalizations.delegate,
        // 负责文字方向 (从左向右)
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
