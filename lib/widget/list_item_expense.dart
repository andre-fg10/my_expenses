import 'package:flutter/material.dart';
import 'package:my_despesas/widget/item_expense.dart';
import 'package:my_despesas/model/expense.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.listExpenses,
  });

  final List<Expense> listExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listExpenses.length,
      itemBuilder: (ctx, index) {
        return ItemExpense(
          expense: listExpenses[index],
        );
      },
    );
  }
}
