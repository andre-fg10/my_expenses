import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_despesas/model/expense.dart';

class UserExpensesNotifier extends StateNotifier<List<Expense>> {
  UserExpensesNotifier() : super(const []);

  void addExpense(Expense expense) {
    state = [expense, ...state];
  }
}

final userExpensesProvider =
    StateNotifierProvider<UserExpensesNotifier, List<Expense>>(
        (ref) => UserExpensesNotifier());
