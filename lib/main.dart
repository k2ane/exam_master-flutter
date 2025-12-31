import 'package:exam_master_flutter/providers/locale/locale_provider.dart';
import 'package:exam_master_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: ExamApp()));
}

class ExamApp extends ConsumerWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeControllerProvider);
    final lightColorSchema = ColorScheme.fromSeed(
      seedColor: Colors.purple, // 🌱 你的种子颜色
      brightness: Brightness.light,
    );
    final darkColorSchema = ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.dark,
    );
    final goRouter = ref.watch(routerProvider);
    return MaterialApp.router(
      title: "Bondex训练场",
      routerConfig: goRouter,
      themeMode: ThemeMode.system,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

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
      locale: currentLocale, // 绑定当前语言
    );
  }
}
