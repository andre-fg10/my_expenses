import 'package:flutter/material.dart';
import 'package:my_despesas/model/expense.dart';

class ItemExpense extends StatelessWidget {
  const ItemExpense({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 119, 101, 255),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(26, 0, 0, 0),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              )
            ]),
        width: 50,
        height: 25,
        child: Text(
          expense.category.title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        expense.title,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      trailing: Text(
        '${expense.amount.toStringAsFixed(2)} €',
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
