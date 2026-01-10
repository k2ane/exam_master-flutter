import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArenaCardWidget extends ConsumerWidget {
  final String cardTitle;
  final String subTitle;
  final String iamgeUrl;
  final EdgeInsets? padding;
  final Color? badgeColor;
  final Color? textColor;
  final void Function()? action;
  const ArenaCardWidget({
    super.key,
    required this.cardTitle,
    required this.subTitle,
    required this.iamgeUrl,
    this.padding,
    this.action,
    this.badgeColor,
    this.textColor,
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
            gaplessPlayback: true,
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
                    SizedBox(height: 4),
                    // Badge(
                    //   label: Text(
                    //     subTitle,
                    //     style: TextStyle().copyWith(
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),

                    //   textColor:
                    //       textColor ??
                    //       Theme.of(context).colorScheme.surfaceContainer,
                    //   backgroundColor:
                    //       badgeColor ?? Theme.of(context).colorScheme.primary,
                    //   // child: Text(subTitle),
                    // ),
                    Text(
                      subTitle,
                      style: TextStyle().copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            badgeColor ?? Theme.of(context).colorScheme.primary,
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
