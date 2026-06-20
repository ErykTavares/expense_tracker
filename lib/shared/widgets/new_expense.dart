import 'package:expense_tracker/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: Theme.of(context).colorScheme.primary,
              headerForegroundColor: Theme.of(context).colorScheme.onPrimary,
              dividerColor: Theme.of(context).colorScheme.primary,
            ),
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void onCancel() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text(
                'Title',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text(
                      'Amount',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Row(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? "Select Date"
                                : formatter.format(_selectedDate!),
                          ),
                          Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Button(
                text: "Cancel",
                onPressed: onCancel,
                bgColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.onError,
              ),
              Button(
                text: "Save Expense",
                onPressed: () {
                  print("====================");
                  print("title: ${_titleController.text}");
                  print("====================");
                  print("amount: ${_amountController.text}");
                  print("====================");
                  print("date: ${_selectedDate.toString()}");
                  print("====================");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
