import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Theme.of(context).colorScheme.surface;
    Color primaryColor = Theme.of(context).colorScheme.primary;

    String categoryManagementText =
        AppLocalizations.of(context)!.categoryManagement;
    return Drawer(
      backgroundColor: surfaceColor,
      child: Column(
        children: [
          Container(
            color: primaryColor,
            height: 100,
            width: double.infinity,
          ),
          Card(
            child: ListTile(
              onTap: () {},
              title: Text(categoryManagementText),
              leading: const Icon(Icons.category),
            ),
          )
        ],
      ),
    );
  }
}
