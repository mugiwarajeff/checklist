import 'package:checklist/app/features/category_management/models/category.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  const CategoryList({super.key, required this.categories});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [],
    );
  }
}
