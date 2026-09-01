import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/transaction_model.dart';
import '../theme/app_theme.dart';
import '../widgets/action_card.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/transaction_tile.dart';

/// Screen for adding local income and expense transactions with setState.
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final List<String> _categories = const [
    'Food',
    'Transfer',
    'Salary',
    'Transport',
    'Shopping',
    'Bills',
    'Work',
    'Gift',
    'Other',
  ];

  Future<void> _showAddSheet({required bool isIncome}) async {
    final amountController = TextEditingController();
    final titleController = TextEditingController();
    String selectedCategory = _categories.first;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                22,
                20,
                MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isIncome ? 'Add Income' : 'Add Expenses',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      prefixText: '\$ ',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Title / Note',
                      hintText: 'e.g. Lunch',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    dropdownColor: cardDark,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setSheetState(() => selectedCategory = value);
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final amount = double.tryParse(
                          amountController.text.trim(),
                        );
                        final title = titleController.text.trim();

                        if (amount == null || amount <= 0 || title.isEmpty) {
                          ScaffoldMessenger.of(sheetContext).showSnackBar(
                            const SnackBar(
                              content: Text('Enter a valid amount and title.'),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          DummyData.dummyTransactions.insert(
                            0,
                            Transaction(
                              title: title,
                              icon: isIncome
                                  ? Icons.arrow_downward_rounded
                                  : Icons.arrow_upward_rounded,
                              time: TimeOfDay.now().format(context),
                              amount: amount,
                              isIncome: isIncome,
                              category: selectedCategory,
                            ),
                          );
                        });

                        Navigator.pop(sheetContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isIncome ? incomeGreen : expenseRed,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    amountController.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactions = DummyData.dummyTransactions;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.grid_view_rounded, color: Colors.white, size: 25),
                  const SizedBox(width: 12),
                  const Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  ActionCard(
                    label: 'Add Income',
                    bgColor: cardLightGreen,
                    iconColor: incomeGreen,
                    icon: Icons.arrow_downward_rounded,
                    onTap: () => _showAddSheet(isIncome: true),
                  ),
                  const SizedBox(width: 12),
                  ActionCard(
                    label: 'Add Expenses',
                    bgColor: cardPeach,
                    iconColor: expenseRed,
                    icon: Icons.arrow_upward_rounded,
                    onTap: () => _showAddSheet(isIncome: false),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Last Added',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 12),
                  itemCount: transactions.length,
                  itemBuilder: (_, index) {
                    return TransactionTile(transaction: transactions[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 1,
        onTap: (index) => navigateToScreen(context, index),
      ),
    );
  }
}
