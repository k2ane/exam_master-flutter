import 'dart:async';

import 'package:exam_master_flutter/providers/secure_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfo {
  final String email;
  final String id;
  final String name;
  UserInfo({required this.email, required this.id, required this.name});
}

final userInfoProvider = AsyncNotifierProvider<UserInfoNotifier, UserInfo>(() {
  return UserInfoNotifier();
});

class UserInfoNotifier extends AsyncNotifier<UserInfo> {
  @override
  FutureOr<UserInfo> build() async {
    final userEmail = await ref.read(secureStorageProvider).getUserEmail();
    final userId = await ref.read(secureStorageProvider).getUserId();
    final userName = await ref.read(secureStorageProvider).getUserName();
    final userInfo = UserInfo(
      email: userEmail as String,
      id: userId as String,
      name: userName as String,
    );
    return userInfo;
  }
}
