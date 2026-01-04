import 'package:flutter_riverpod/flutter_riverpod.dart';

// 暴露给全局,到时候可以通过 ConsumerStatefulWidget 或 ConsumerWidget 中的 ref 进行访问
final globalEmailProvider = StateProvider<String>((ref) => '');
