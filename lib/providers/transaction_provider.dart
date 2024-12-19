import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../helpers/database_helper.dart';

class TransactionProvider extends ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  Future<void> fetchTransactions() async {
    _transactions.clear();
    _transactions.addAll(await DatabaseHelper.instance.getTransactions());
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await DatabaseHelper.instance.insertTransaction(transaction);
    fetchTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await DatabaseHelper.instance.deleteTransaction(id);
    fetchTransactions();
  }
}
