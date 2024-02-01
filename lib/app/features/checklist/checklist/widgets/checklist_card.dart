import 'package:checklist/app/features/checklist/checklist_item/checklist_item_view.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:flutter/material.dart';

class CheckListCard extends StatelessWidget {
  final CheckList checkList;
  const CheckListCard({super.key, required this.checkList});

  @override
  Widget build(BuildContext context) {
    final Color borderCardColor = Theme.of(context).colorScheme.onBackground;
    final double widthCard = MediaQuery.of(context).size.width;
    final double heightCard = MediaQuery.of(context).size.width;
    const double textSize = 24;

    void navigateToCheckListPage() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckListItemView(checkList: checkList)));
    }

    return Card(
      child: Container(
        width: widthCard / 2.5,
        height: heightCard / 2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2, color: borderCardColor),
        ),
        child: Center(
            child: Text(
          checkList.title.value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: textSize),
        )),
      ),
    );
  }
}
