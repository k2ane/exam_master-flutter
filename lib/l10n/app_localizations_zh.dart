// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '海关考试系统';

  @override
  String get loginTitle => '用户登录';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get inputEmail => '请输入邮箱';

  @override
  String get inputPassword => '请输入密码';

  @override
  String get btnLogin => '立即登录';

  @override
  String get btnRegister => '注册新账号';

  @override
  String get dialogLoginSuccess => '登录成功';

  @override
  String get dialogJumping => '正在跳转到考试系统...';

  @override
  String get loginTiitleMessage => '欢迎使用该系统';
}
