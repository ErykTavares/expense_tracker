import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/shared/widgets/expenses_List/expenses_list.dart';
import 'package:expense_tracker/shared/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // final List<Expense> _registeredExpenses = [
  //   Expense(
  //     title: 'Japão',
  //     amount: 3500,
  //     category: Category.travel,
  //     date: DateTime(2026, 7, 15),
  //   ),
  //   Expense(
  //     title: 'One piece Stampede',
  //     amount: 18.99,
  //     category: Category.leisure,
  //     date: DateTime.now(),
  //   ),
  //   Expense(
  //     title: 'Home Renovation',
  //     amount: 5370,
  //     category: Category.work,
  //     date: DateTime(2026, 5, 05),
  //   ),
  //   Expense(
  //     title: 'Shrimp bean ball',
  //     amount: 22.50,
  //     category: Category.food,
  //     date: DateTime(2026, 4, 23),
  //   ),
  // ];
  final List<Expense> _registeredExpenses = [];

  void onAddExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void onRemoveExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _openAddNewExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: onAddExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(fontSize: 16),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: onRemoveExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Expense Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: _openAddNewExpenseOverlay,
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: Column(
        spacing: 4,
        children: [
          const SizedBox(height: 4),
          const Text(
            'The chart',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
