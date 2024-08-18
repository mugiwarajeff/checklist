import 'package:checklist/app/features/category_management/controllers/category_management_controller.dart';
import 'package:checklist/app/features/category_management/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CategoryManagementView extends StatefulWidget {
  const CategoryManagementView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoryManagementViewState();
  }
}

class _CategoryManagementViewState extends State<CategoryManagementView> {
  @override
  Widget build(BuildContext context) {
    CategoryManagementController categoryManagementController =
        Provider.of<CategoryManagementController>(context);
    String categoryManagementText =
        AppLocalizations.of(context)!.categoryManagement;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryManagementText),
      ),
      body: CategoryList(
        categories: categoryManagementController.categories,
      ),
    );
  }
}
