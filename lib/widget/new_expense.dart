import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpense});
  final void Function(Expense expense) addNewExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _showDatePickr() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text("Invaled Input"),
          content: Text(
            "Plase make sure a valid title, amount, date, category...",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invaled Input"),
          content: Text(
            "Plase make sure a valid title, amount, date, category...",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submetData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.addNewExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

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
    final keypordSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraint) {
        final widthConstraint = constraint.maxWidth;
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 50, 15, keypordSpace + 15),
              child: Column(
                //! //////////// TITLE TEXTFIELD ///////////////////////
                children: [
                  if (widthConstraint >= 600)
                    //! //////////// Horizotel Layout ///////////////////////
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: InputDecoration(label: Text('Title')),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefixText: "\$",
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    //! //////////// Virtecal Layout ///////////////////////
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: InputDecoration(label: Text('Title')),
                    ),
                  if (widthConstraint >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (e) {
                            if (e == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = e;
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "No Date Selected Yet!"
                                    : formatter.format(_selectedDate!),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              IconButton(
                                onPressed: _showDatePickr,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      //! //////////////// AMOUNT TEXTFIELD //////////////
                      children: [
                        //! ///////////////////// Vertical Layout ///////////
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefixText: "\$",
                            ),
                          ),
                        ),
                        //! ///////////////////// Vertical DATE BACKER ///////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "No Date Selected Yet!"
                                  : formatter.format(_selectedDate!),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            IconButton(
                              onPressed: _showDatePickr,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(height: 15),
                  //! ///////////////////////////ROW BUTTONS //////////
                  if (widthConstraint >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        //! ///////////////// SAVE EXPENSE BUTTON /////////////////////
                        ElevatedButton(
                          onPressed: _submetData,
                          child: Text('Save Expense'),
                        ),
                        SizedBox(width: 10),
                        //! ///////////////// CANCLE TEXTBUTTON /////////////////////
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancle"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        //! //////////////////// DROPDOWNBUTTON/////////
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (e) {
                            if (e == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = e;
                            });
                          },
                        ),
                        const Spacer(),
                        //! ///////////////// SAVE EXPENSE BUTTON /////////////////////
                        ElevatedButton(
                          onPressed: _submetData,
                          child: Text('Save Expense'),
                        ),
                        SizedBox(width: 10),
                        //! ///////////////// CANCLE TEXTBUTTON /////////////////////
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancle"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
