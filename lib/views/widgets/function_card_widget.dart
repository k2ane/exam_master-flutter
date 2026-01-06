import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FunctionCardWidget extends ConsumerWidget {
  final void Function()? ontap;
  const FunctionCardWidget({super.key, this.ontap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        margin: EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: ontap ?? () => {},
          contentPadding: EdgeInsets.all(12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '顺序练题',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    '按照顺序进行答题',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(200),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.navigate_next,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Divider(height: 1, thickness: 1),
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.1,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withAlpha(80),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '进度: 20/1520',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary.withAlpha(200),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
