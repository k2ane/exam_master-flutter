import 'package:exam_master_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: ExamApp()));
}

class ExamApp extends ConsumerWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightColorSchema = ColorScheme.fromSeed(
      seedColor: Colors.orange, // 🌱 你的种子颜色
      brightness: Brightness.light,
    );
    final darkColorSchema = ColorScheme.fromSeed(
      seedColor: Colors.orange,
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
