import 'package:flutter/material.dart';

import '../models/transaction_model.dart';

/// Local transaction store and calculation helpers. No backend or network is used.
class DummyData {
  static final List<Transaction> dummyTransactions = [
    const Transaction(
      title: 'Waafi',
      icon: Icons.account_balance_wallet_rounded,
      time: '12:22 PM',
      amount: 30.00,
      isIncome: true,
      category: 'Transfer',
    ),
    const Transaction(
      title: 'Break Fast',
      icon: Icons.restaurant_rounded,
      time: '10:15 AM',
      amount: 3.60,
      isIncome: false,
      category: 'Food',
    ),
    const Transaction(
      title: 'Salary',
      icon: Icons.payments_rounded,
      time: '09:00 AM',
      amount: 650.00,
      isIncome: true,
      category: 'Salary',
    ),
    const Transaction(
      title: 'Uber',
      icon: Icons.local_taxi_rounded,
      time: '08:30 AM',
      amount: 7.50,
      isIncome: false,
      category: 'Transport',
    ),
    const Transaction(
      title: 'Coffee',
      icon: Icons.coffee_rounded,
      time: '07:45 AM',
      amount: 2.50,
      isIncome: false,
      category: 'Food',
    ),
    const Transaction(
      title: 'Freelance',
      icon: Icons.laptop_mac_rounded,
      time: 'Yesterday',
      amount: 120.00,
      isIncome: true,
      category: 'Work',
    ),
    const Transaction(
      title: 'Internet',
      icon: Icons.wifi_rounded,
      time: 'Yesterday',
      amount: 18.00,
      isIncome: false,
      category: 'Bills',
    ),
    const Transaction(
      title: 'Transfer',
      icon: Icons.swap_horiz_rounded,
      time: 'Yesterday',
      amount: 45.00,
      isIncome: false,
      category: 'Transfer',
    ),
    const Transaction(
      title: 'Gift',
      icon: Icons.card_giftcard_rounded,
      time: 'Monday',
      amount: 25.00,
      isIncome: true,
      category: 'Gift',
    ),
    const Transaction(
      title: 'Groceries',
      icon: Icons.shopping_basket_rounded,
      time: 'Monday',
      amount: 42.75,
      isIncome: false,
      category: 'Shopping',
    ),
  ];

  static double getTotalIncome(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.isIncome)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  static double getTotalExpenses(List<Transaction> transactions) {
    return transactions
        .where((transaction) => !transaction.isIncome)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  static double getBalance(List<Transaction> transactions) {
    return getTotalIncome(transactions) - getTotalExpenses(transactions);
  }
}
