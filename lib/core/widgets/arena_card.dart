import 'package:flutter/material.dart';

class ArenaCard extends StatelessWidget {
  final String cardTitle;
  final String cardDescription;
  final IconData cardIcon;
  const ArenaCard({
    super.key,
    required this.cardTitle,
    required this.cardDescription,
    required this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(cardIcon, size: 48),
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
                  Badge(backgroundColor: Colors.amber, label: Text('基本')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
