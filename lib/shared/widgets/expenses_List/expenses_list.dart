import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/shared/widgets/expenses_List/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  Widget listViewBuilder(BuildContext ctx, int index) => Dismissible(
    onDismissed: (direction) {
      if (direction == DismissDirection.startToEnd) {
        onRemoveExpense(expenses[index]);
      }
    },
    direction: DismissDirection.startToEnd,
    key: ValueKey(expenses[index]),
    child: ExpensesItem(expense: expenses[index]),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: listViewBuilder,
      itemCount: expenses.length,
    );
  }
}
