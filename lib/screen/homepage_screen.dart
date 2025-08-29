import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_despesas/providers/user_expenses.dart';
import 'package:my_despesas/widget/list_item_expense.dart';
import 'package:my_despesas/widget/summary.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listExpenses = ref.watch(userExpensesProvider);

    Widget list_expense = const Center(
      child: Text('No expenses added yet!'),
    );

    if (listExpenses.isNotEmpty) {
      list_expense = ListItem(
        listExpenses: listExpenses,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Summary(
            expenses: listExpenses,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Expenses List',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Card(
            margin: EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            child: list_expense,
          ),
        ],
      ),
    );
  }
}
