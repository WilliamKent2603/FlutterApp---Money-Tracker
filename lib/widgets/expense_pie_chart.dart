import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class ExpensePieChart extends StatelessWidget {
  final List<Transaction> transactions;

  const ExpensePieChart({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseData = _calculateExpenses();

    return PieChart(
      PieChartData(
        sections: expenseData.map((data) {
          return PieChartSectionData(
            color: data['color'],
            value: data['value'],
            title: '${data['label']}',
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Map<String, dynamic>> _calculateExpenses() {
    final Map<String, double> expenseMap = {};

    for (final transaction in transactions) {
      if (transaction.amount < 0) {
        final category = transaction.description;
        expenseMap[category] = (expenseMap[category] ?? 0) + transaction.amount.abs();
      }
    }

    final totalExpenses = expenseMap.values.fold(0.0, (sum, value) => sum + value);

    final List<Map<String, dynamic>> expenseData = [];
    expenseMap.forEach((key, value) {
      expenseData.add({
        'label': key,
        'value': (
::contentReference[oaicite:0]{index=0}
 
