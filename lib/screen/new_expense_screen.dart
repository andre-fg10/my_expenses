import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_despesas/model/category.dart';
import 'package:my_despesas/model/expense.dart';
import 'package:my_despesas/providers/user_expenses.dart';
import 'package:my_despesas/screen/homepage_tab_screen.dart';
import 'package:my_despesas/widget/dropdown_categories.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewExpenseBody(),
    );
  }
}

class NewExpenseBody extends ConsumerStatefulWidget {
  const NewExpenseBody({super.key});

  @override
  ConsumerState<NewExpenseBody> createState() {
    return _NewExpenseBodyState();
  }
}

class _NewExpenseBodyState extends ConsumerState<NewExpenseBody> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  Category? _selectedCategory;
  var _title = '';
  var _amount = 1.0;

  void _callDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(2025, 1, 1);
    final lastDate = DateTime(2100, 12, 31);

    var dateSelected = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = dateSelected;
    });
  }

  void submitExpense() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please, select a valid date.')),
      );
      return;
    }

    if(_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please, add at least one category.')),
      );
      return;
    }

    ref.read(userExpensesProvider.notifier).addExpense(Expense(
        title: _title,
        amount: _amount,
        date: _selectedDate!,
        category: Category(title: _selectedCategory!.title)));

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
              maxLength: 50,
              decoration: InputDecoration(
                label: Text('Title'),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length >= 50) {
                  return 'Must be between 1 and 50 characters.';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Amount'),
                      suffixText: ' €',
                    ),
                    initialValue: _amount.toString(),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null ||
                          double.tryParse(value)! <= 0) {
                        return 'Must be a valid, positive number.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _amount = double.parse(value!);
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'No date selected'
                          : DateFormat('dd/mm/yyyy').format(_selectedDate!)),
                      IconButton(
                        onPressed: _callDatePicker,
                        icon: Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            DropdownCategories(
              onSaved: (value) => _selectedCategory = value,
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary
                  ),
                  onPressed: submitExpense,
                  child: Text('Add', style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
