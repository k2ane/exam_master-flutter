import 'package:flutter/material.dart';

class ArenaCard extends StatelessWidget {
  final String cardTitle;
  final String cardDescription;
  final IconData cardIcon;
  final String cardBadge;
  final Color badgeColor;
  final String pushUrl;
  final Object paramArgs;
  final bool showProgress;
  const ArenaCard({
    super.key,
    required this.cardTitle,
    this.cardDescription = "未提供",
    required this.cardIcon,
    required this.cardBadge,
    required this.badgeColor,
    required this.pushUrl,
    required this.paramArgs,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, pushUrl, arguments: paramArgs),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: showProgress
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(cardIcon, size: 36),
                            Text(
                              cardTitle,
                              style: TextStyle(fontSize: 20, fontWeight: .w300),
                            ),

                            SizedBox(height: 10),
                          ],
                        ),
                        Icon(Icons.chevron_right_outlined),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Badge(
                          backgroundColor: badgeColor,
                          label: Text(cardBadge),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: 0.10133333,
                                  backgroundColor: Colors.black,
                                  color: Colors.blue,
                                  minHeight: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      '已练习题目: 150/1520',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(cardIcon, size: 36),
                            Text(
                              cardTitle,
                              style: TextStyle(fontSize: 20, fontWeight: .w300),
                            ),

                            SizedBox(height: 10),
                          ],
                        ),
                        Icon(Icons.chevron_right_outlined),
                      ],
                    ),
                    Row(
                      children: [
                        Badge(
                          backgroundColor: badgeColor,
                          label: Text(cardBadge),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
