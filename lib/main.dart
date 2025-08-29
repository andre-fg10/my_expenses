import 'package:flutter/material.dart';
import 'package:my_despesas/my_expenses.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyExpenses()));
}