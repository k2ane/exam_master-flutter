import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GiftView extends ConsumerStatefulWidget {
  const GiftView({super.key});
  @override
  ConsumerState<GiftView> createState() => _GiftView();
}

class _GiftView extends ConsumerState<GiftView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text('兑换奖品')),
      body: ListView(padding: EdgeInsets.all(16), children: [Text('这是兑换奖品页面')]),
    );
  }
}
