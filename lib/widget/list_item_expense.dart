import 'package:flutter/material.dart';
import 'package:my_despesas/widget/item_expense.dart';
import 'package:my_despesas/model/expense.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    super.key,
    required this.listExpenses,
  });

  final List<Expense> listExpenses;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.listExpenses.length,
        itemBuilder: (ctx, index) {
          return ItemExpense(
            expense: widget.listExpenses[index],
          );
        },
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
