import 'package:exam_master_flutter/views/widgets/login_from_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: kIsWeb
            ? Row(
                children: [
                  SizedBox(
                    width: 500,
                    height: double.infinity,
                    child: LoginFromWidget(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image(
                      image: AssetImage('assets/login_background_image.jpg'),
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                ],
              )
            : LoginFromWidget(),
      ),
    );
  }
}
