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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The cart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
