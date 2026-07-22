import 'package:expense_tracker/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.food;
  final categoryDropdownList = Category.values
      .map(
        (item) =>
            DropdownMenuItem(value: item, child: Text(item.name.toUpperCase())),
      )
      .toList();

  Widget dateDialogBuilder(context, child) {
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
  }

  Widget submitFormDialogBuilder(ctx) => AlertDialog(
    title: const Text("Invalid fields!"),
    content: const Text(
      "Please make sure a valid title, amount, and date was entered.",
    ),
    actions: [
      Button(
        text: "Okay",
        onPressed: () {
          Navigator.pop(ctx);
        },
      ),
    ],
  );

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 30)),
      builder: dateDialogBuilder,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void onSetCategory(Category? category) {
    if (category == null) {
      return;
    }

    setState(() {
      _selectedCategory = category;
    });
  }

  void onSubmitForm() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(context: context, builder: submitFormDialogBuilder);
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );

    Navigator.pop(context);
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
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
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
            spacing: 16,
            children: [
              const SizedBox(width: 1),
              DropdownButton(
                items: categoryDropdownList,
                value: _selectedCategory,
                onChanged: onSetCategory,
              ),
              const Spacer(),
              Button(
                text: "Cancel",
                onPressed: onCancel,
                bgColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.onError,
              ),
              Button(text: "Save Expense", onPressed: onSubmitForm),
            ],
          ),
        ],
      ),
    );
  }
}
