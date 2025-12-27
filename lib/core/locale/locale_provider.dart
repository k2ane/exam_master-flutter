import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleController extends _$LocaleController {
  @override
  Locale build() {
    // 默认跟随系统，或者强制设为中文
    // 如果要持久化，可以在这里读取 StorageService
    return const Locale('zh');
  }

  void switchLocale() {
    if (state.languageCode == 'zh') {
      state = const Locale('en');
    } else {
      state = const Locale('zh');
    }
  }
}
