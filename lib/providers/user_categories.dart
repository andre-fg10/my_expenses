import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_despesas/model/category.dart';

class UserCategoriesNotifier extends StateNotifier<List<Category>> {
  UserCategoriesNotifier() : super(const []);

  void addCategory(Category category) {
    state = [category, ...state];
  }
}

final userCategoriesProvider =
    StateNotifierProvider<UserCategoriesNotifier, List<Category>>(
        (ref) => UserCategoriesNotifier());
