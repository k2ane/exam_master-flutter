// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Exam Master';

  @override
  String get loginTitle => 'User Login';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get inputEmail => 'Enter Email';

  @override
  String get inputPassword => 'Enter Password';

  @override
  String get btnLogin => 'Login Now';

  @override
  String get btnRegister => 'Register';

  @override
  String get dialogLoginSuccess => 'Success';

  @override
  String get dialogJumping => 'Redirecting to dashboard...';

  @override
  String get loginTiitleMessage => 'Welcome to use the exam system';
}
