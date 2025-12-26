import 'package:riverpod_annotation/riverpod_annotation.dart';

// 这一行必须写，用于代码生成
part 'login_controller.g.dart';

// ViewModel: 管理登录状态
// AsyncValue<void> 自动处理了三种状态: data(空闲/成功), loading(加载中), error(报错)
@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    // 初始状态什么都不做
  }

  // 业务逻辑: 登录方法
  Future<void> login(String email, String password) async {
    // 1. 设置状态为 "加载中"
    state = const AsyncValue.loading();

    // 2. 模拟网络请求 (延迟2秒)
    // 实际项目中这里会调用 Repository 层去请求服务器
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));

      if (email.isEmpty || password.isEmpty) {
        throw Exception('邮箱或密码不能为空');
      }

      // 模拟成功
      return;
    });
  }
}
