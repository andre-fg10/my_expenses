import 'package:flutter/material.dart';
import 'package:my_despesas/screen/homepage_screen.dart';
import 'package:my_despesas/screen/new_category_screen.dart';
import 'package:my_despesas/screen/new_expense_screen.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key, this.selectedPageIndex = 1});

  final int selectedPageIndex;

  @override
  State<HomePageTab> createState() {
    return _HomePageTabState();
  }
}

class _HomePageTabState extends State<HomePageTab> {
  late int _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.selectedPageIndex;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomePage();

    var activePageTitle = 'My Expenses';

    if (_selectedPageIndex == 0) {
      activePage = NewCategory();
      activePageTitle = 'New Category';
    } else if (_selectedPageIndex == 2) {
      activePage = NewExpense();
      activePageTitle = 'New Expense';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        automaticallyImplyLeading: false
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'New category'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet), label: 'New expense'),
          ]),
    );
  }
}
