import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/summary_card.dart';
import '../widgets/transaction_tile.dart';

/// Overview screen with income/expense summaries and a filter toggle.
class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  bool isExpensesSelected = true;

  @override
  Widget build(BuildContext context) {
    final transactions = DummyData.dummyTransactions;
    final income = DummyData.getTotalIncome(transactions);
    final expenses = DummyData.getTotalExpenses(transactions);
    final filtered = transactions
        .where((transaction) =>
            transaction.isIncome != isExpensesSelected)
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => navigateToScreen(context, 0),
                    icon: const Icon(Icons.arrow_back_rounded),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  SummaryCard(
                    label: 'Total Income',
                    amount: income,
                    bgColor: cardLightGreen,
                    iconColor: incomeGreen,
                    icon: Icons.arrow_downward_rounded,
                  ),
                  const SizedBox(width: 12),
                  SummaryCard(
                    label: 'Total Expenses',
                    amount: expenses,
                    bgColor: cardPeach,
                    iconColor: expenseRed,
                    icon: Icons.arrow_upward_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: _TogglePill(
                      label: 'Income',
                      selected: !isExpensesSelected,
                      color: incomeGreen,
                      onTap: () => setState(() => isExpensesSelected = false),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _TogglePill(
                      label: 'Expenses',
                      selected: isExpensesSelected,
                      color: expenseRed,
                      onTap: () => setState(() => isExpensesSelected = true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Text(
                    isExpensesSelected ? 'All Expenses' : 'All Income',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'See All',
                    style: TextStyle(color: greyText, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(
                        child: Text(
                          'No transactions yet',
                          style: TextStyle(color: greyText),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 12),
                        itemCount: filtered.length,
                        itemBuilder: (_, index) {
                          return TransactionTile(
                            transaction: filtered[index],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 2,
        onTap: (index) => navigateToScreen(context, index),
      ),
    );
  }
}

/// Reusable income/expense pill selector.
class _TogglePill extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _TogglePill({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? color : cardDark,
          borderRadius: BorderRadius.circular(pillRadius),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
