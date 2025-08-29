import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_despesas/model/category.dart';
import 'package:my_despesas/providers/user_categories.dart';
import 'package:my_despesas/screen/homepage_tab_screen.dart';

class NewCategory extends StatelessWidget {
  const NewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyNewCategory(),
    );
  }
}

class BodyNewCategory extends ConsumerStatefulWidget {
  const BodyNewCategory({super.key});

  @override
  ConsumerState<BodyNewCategory> createState() {
    return _BodyNewCategoryState();
  }
}

class _BodyNewCategoryState extends ConsumerState<BodyNewCategory> {
  final _formKey = GlobalKey<FormState>();
  var _title = '';

  void submitCategory() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    ref
        .read(userCategoriesProvider.notifier)
        .addCategory(Category(title: _title));

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePageTab()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 10,
              decoration: InputDecoration(
                label: Text('Title'),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length >= 10) {
                  return 'Must be between 1 and 10 characters';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePageTab()));
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 16,),
                ElevatedButton(
                  onPressed: submitCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
