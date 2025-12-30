import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // 控制器，用于获取输入的验证码
  final TextEditingController _pinController = TextEditingController();
  // 焦点控制
  final FocusNode _focusNode = FocusNode();

  Timer? _timer; // 定时器对象
  int _cout = 60; // 倒计时秒数
  bool _isCounting = false; // 记录当前是否正在倒计时
  bool _isClickedGetCodeButton = false;

  void _startTimer() {
    setState(() {
      _isCounting = true;
      _cout = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_cout == 0) {
        setState(() {
          timer.cancel();
          _isCounting = false;
        });
      } else {
        setState(() {
          _cout--;
        });
      }
      ;
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    // 定义默认样式
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
    );
    // 定义聚焦样式
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Theme.of(context).colorScheme.surface, // 背景变白
      border: Border.all(
        color: Theme.of(context).primaryColor, // 边框变主题色
        width: 2,
      ),
    );
    // 定义错误样式
    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.redAccent, width: 2),
      color: Colors.red[50],
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('输入验证码')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                _isClickedGetCodeButton
                    ? "请输入已发送到 ${widget.email} 的 6 位代码"
                    : "验证码将发送到 ${widget.email}",
              ),
              const SizedBox(height: 40),
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                length: 6, // 验证码长度
                controller: _pinController,
                focusNode: _focusNode,

                // 样式配置
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                errorPinTheme: errorPinTheme, // 如果你调用了 forceErrorState
                // 交互配置
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true, // 显示光标
                // ✅ 当用户输完最后一位数字时触发
                onCompleted: (pin) {
                  debugPrint("用户输完了: $pin");
                  // _verifyCode(pin);
                },
              ),

              const SizedBox(height: 50),

              // 提交按钮 (可选，用户也可以输完自动提交)
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isCounting
                      ? null
                      : () => {
                          _startTimer(),
                          setState(() {
                            _isClickedGetCodeButton = true;
                          }),
                        },
                  child: Text(_isCounting ? "${_cout} 秒后重试" : "获取验证码"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
