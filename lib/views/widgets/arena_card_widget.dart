import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArenaCardWidget extends ConsumerWidget {
  final String cardTitle;
  final String subTitle;
  final String iamgeUrl;
  final EdgeInsets? padding;
  final void Function()? action;
  const ArenaCardWidget({
    super.key,
    required this.cardTitle,
    required this.subTitle,
    required this.iamgeUrl,
    this.padding,
    this.action,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: padding ?? EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        child: ListTile(
          onTap: action ?? () => {},
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.all(0),
          title: Image.asset(
            'assets/$iamgeUrl',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cardTitle, style: TextStyle().copyWith(fontSize: 20)),
                    Text(
                      subTitle,
                      style: TextStyle().copyWith(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
