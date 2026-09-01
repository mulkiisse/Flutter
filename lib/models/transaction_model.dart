import 'package:flutter/material.dart';

/// Represents one income or expense transaction stored locally.
class Transaction {
  final String title;
  final IconData icon;
  final String time;
  final double amount;
  final bool isIncome;
  final String category;

  const Transaction({
    required this.title,
    required this.icon,
    required this.time,
    required this.amount,
    required this.isIncome,
    this.category = 'Other',
  });
}
