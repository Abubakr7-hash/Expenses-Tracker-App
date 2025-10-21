import 'package:flutter/material.dart';

import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _regestredExpenses = [];

  void _openAddExpenses() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctxt) {
        return NewExpense(addNewExpense: _expenseAdd);
      },
    );
  }

  void _expenseAdd(Expense expense) {
    setState(() {
      _regestredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense xpn) {
    final expenseIndex = _regestredExpenses.indexOf(xpn);
    setState(() {
      _regestredExpenses.remove(xpn);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo!",
          onPressed: () {
            setState(() {
              _regestredExpenses.insert(expenseIndex, xpn);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    //! print(deviceWidth);
    Widget mainContent = Center(
      child: Text(
        " Hi There, you can add a new expenses... ",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
    if (_regestredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _regestredExpenses,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpenses, icon: Icon(Icons.add)),
        ],
      ),
      body: deviceWidth < 500
          ?
            //! /////// Orientation Check //////////
            Column(
              children: [
                if (_regestredExpenses.isNotEmpty)
                  Chart(expenses: _regestredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _regestredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
