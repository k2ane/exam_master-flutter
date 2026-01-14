import 'dart:async';

import 'package:exam_master_flutter/providers/secure_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfo {
  final String email;
  final String id;
  UserInfo({required this.email, required this.id});
}

final userInfoProvider = AsyncNotifierProvider<UserInfoNotifier, UserInfo>(() {
  return UserInfoNotifier();
});

class UserInfoNotifier extends AsyncNotifier<UserInfo> {
  @override
  FutureOr<UserInfo> build() async {
    final userEmail = await ref.read(secureStorageProvider).getUserEmail();
    final userId = await ref.read(secureStorageProvider).getUserId();
    final userInfo = UserInfo(email: userEmail as String, id: userId as String);
    return userInfo;
  }
}
