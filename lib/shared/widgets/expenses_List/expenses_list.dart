import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/shared/widgets/expenses_List/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  Widget listViewBuilder(BuildContext ctx, int index) =>
      ExpensesItem(expense: expenses[index]);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: listViewBuilder,
      itemCount: expenses.length,
    );
  }
}
