import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/balance_card.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/transaction_tile.dart';

/// Home dashboard showing the current balance and recent transactions.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final transactions = DummyData.dummyTransactions;
    final income = DummyData.getTotalIncome(transactions);
    final expenses = DummyData.getTotalExpenses(transactions);
    final balance = DummyData.getBalance(transactions);

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
                    'Home',
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
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              BalanceCard(
                balance: balance,
                income: income,
                expenses: expenses,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    'Transactions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => navigateToScreen(context, 2),
                    child: const Text(
                      'See All',
                      style: TextStyle(color: greyText, fontSize: 14),
                    ),
                  ),
                ],
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
        currentIndex: 0,
        onTap: (index) => navigateToScreen(context, index),
      ),
    );
  }
}
