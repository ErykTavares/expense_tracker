import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/shared/widgets/expenses_List/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Japão',
      amount: 3500,
      category: Category.travel,
      date: DateTime(2026, 7, 15),
    ),
    Expense(
      title: 'One piece Stampede',
      amount: 18.99,
      category: Category.leisure,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Home Renovation',
      amount: 5370,
      category: Category.work,
      date: DateTime(2026, 5, 05),
    ),
    Expense(
      title: 'Shrimp bean ball',
      amount: 22.50,
      category: Category.food,
      date: DateTime(2026, 4, 23),
    ),
  ];

  void _openAddNewExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [Text("Bottom Sheet")],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Expense Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 108, 4, 4),
        actions: [
          IconButton(
            onPressed: _openAddNewExpenseOverlay,
            icon: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
      body: Column(
        spacing: 4,
        children: [
          const SizedBox(height: 4),
          const Text('The cart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
