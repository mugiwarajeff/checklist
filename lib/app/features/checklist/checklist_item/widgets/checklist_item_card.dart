import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:flutter/material.dart';

class CheckListItemCard extends StatelessWidget {
  final CheckListItem checkListItem;

  const CheckListItemCard({super.key, required this.checkListItem});

  @override
  Widget build(BuildContext context) {
    final Color dividerColor = Theme.of(context).colorScheme.onBackground;
    return Column(
      children: [
        ListTile(
          trailing: Checkbox(
            value: checkListItem.checked,
            onChanged: (value) => print(value),
          ),
          title: Text(checkListItem.title),
        ),
        Divider(
          color: dividerColor,
        )
      ],
    );
  }
}
