import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesStorageProvider =
    Provider<SharedPreferencesStorageProvider>((ref) {
      return SharedPreferencesStorageProvider();
    });

class SharedPreferencesStorageProvider {
  late final SharedPreferencesAsync _storage;
  SharedPreferencesStorageProvider() {
    _storage = SharedPreferencesAsync();
  }

  static const String _userThemeColor = 'user_theme_color';

  Future<void> setUserThemeColor(String color) async {
    await _storage.setString(_userThemeColor, color);
  }

  Future<String?> getUserThemeColor() async {
    return await _storage.getString(_userThemeColor);
  }
}
