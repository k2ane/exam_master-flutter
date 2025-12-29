import 'package:exam_master_flutter/core/locale/locale_provider.dart';
import 'package:exam_master_flutter/core/widgets/responsive_layout.dart';
import 'package:exam_master_flutter/features/auth/view/me_page.dart';
import 'package:exam_master_flutter/features/auth/view/mobile/m_navigation_page.dart';
import 'package:exam_master_flutter/features/auth/view/desktop/d_navigation_page.dart';
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
      seedColor: Colors.blue, // 🌱 你的种子颜色
      brightness: Brightness.light,
    );
    final darkColorSchema = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    );
    return MaterialApp(
      title: "Bondex训练场",
      initialRoute: '/home',
      routes: {
        '/home': (context) => const ResponsiveLayout(
          mobile: MMainNavigationScaffold(),
          desktop: DMainNavigationScaffold(),
        ),
        '/me': (context) => const MePage(),
        '/detail': (context) => const DetailsScreen(),
      },
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
      // 路由逻辑
      // home: ResponsiveLayout(
      //   mobile: MMainNavigationScaffold(),
      //   desktop: DMainNavigationScaffold(),
      // ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String title = args['title'];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) {
          return;
        }
        final shouldPop = await _showExitDialog(context);
        if (shouldPop == true) {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            ),
            child: const Text('测试按钮'),
          ),
        ),
      ),
    );
  }
}

Future<bool?> _showExitDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("确定要退出吗？"),
        content: const Text("现在的答题进度将不会保存。"),
        actions: [
          TextButton(
            onPressed: () {
              // 关闭对话框，返回 false (不退出)
              Navigator.of(context).pop(false);
            },
            child: const Text("取消"),
          ),
          TextButton(
            onPressed: () {
              // 关闭对话框，返回 true (确定退出)
              Navigator.of(context).pop(true);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("确定退出"),
          ),
        ],
      );
    },
  );
}
