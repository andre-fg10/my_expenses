import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_despesas/model/category.dart';
import 'package:my_despesas/providers/user_categories.dart';

class DropdownCategories extends ConsumerWidget {
  const DropdownCategories({super.key, this.onSaved});

  final FormFieldSetter? onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(userCategoriesProvider);

    if (categories.isEmpty) {
      return Text('No categories available. Add at least one.');
    }

    final _selectedCategory = categories.first;

    return DropdownButtonFormField<Category>(
        value: _selectedCategory,
        items: [
          for (final category in categories)
            DropdownMenuItem(
              value: category,
              child: Text(category.title),
            ),
        ],
        onChanged: (_) {},
        onSaved: onSaved);
  }
}
