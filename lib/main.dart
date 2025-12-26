import 'package:exam_master_flutter/features/auth/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ✅ 必须保留：使用刚才生成的实体文件
import 'l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: ExamApp()));
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => PlatformApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,

        // 🎨 安卓主题 (Material 3)
        material: (_, _) => MaterialAppData(
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFFF5F5F5), // 浅灰背景
          ),
        ),

        // 🍎 iOS 主题
        cupertino: (_, _) => CupertinoAppData(
          theme: const CupertinoThemeData(
            primaryColor: Colors.blue,
            scaffoldBackgroundColor:
                CupertinoColors.systemGroupedBackground, // iOS 标准分组背景色
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
