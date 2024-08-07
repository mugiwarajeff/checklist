import 'package:checklist/app/features/checklist/checklist_item/checklist_item_view.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:flutter/material.dart';

class CheckListCard extends StatelessWidget {
  final CheckList checkList;
  const CheckListCard({super.key, required this.checkList});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final double widthCard = MediaQuery.of(context).size.width;
    final double heightCard = MediaQuery.of(context).size.width;
    const double textSize = 24;

    void navigateToCheckListPage() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckListItemView(
                checkListId: checkList.id,
                checkListTitle: checkList.title.value,
              )));
    }

    return GestureDetector(
      onTap: navigateToCheckListPage,
      child: Card(
        child: Container(
          width: widthCard / 2.5,
          height: heightCard / 2.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryColor, tertiaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 3, color: onPrimaryColor),
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              checkList.title.value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: textSize, color: onPrimaryColor),
            ),
          )),
        ),
      ),
    );
  }
}
