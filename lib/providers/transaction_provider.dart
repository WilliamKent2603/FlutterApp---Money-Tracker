import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../helpers/database_helper.dart';

class TransactionProvider extends ChangeNotifier {
  final List<Transaction> _transactions = [];
  bool _isLoading = false; // Status loading
  String _errorMessage = ''; // Untuk menyimpan pesan error

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading; // Getter untuk status loading
  String get errorMessage => _errorMessage; // Getter untuk pesan error

  Future<void> fetchTransactions() async {
    try {
      _isLoading = true; // Mulai proses loading
      _errorMessage = ''; // Reset pesan error
      notifyListeners();

      _transactions.clear();
      final fetchedTransactions =
          await DatabaseHelper.instance.getTransactions();

      if (fetchedTransactions.isNotEmpty) {
        _transactions.addAll(fetchedTransactions);
      } else {
        _errorMessage = 'No transactions available.';
      }
    } catch (error) {
      _errorMessage = 'Failed to fetch transactions: $error';
    } finally {
      _isLoading = false; // Akhiri proses loading
      notifyListeners();
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      await DatabaseHelper.instance.insertTransaction(transaction);
      await fetchTransactions();
    } catch (error) {
      _errorMessage = 'Failed to add transaction: $error';
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await DatabaseHelper.instance.deleteTransaction(id);
      await fetchTransactions();
    } catch (error) {
      _errorMessage = 'Failed to delete transaction: $error';
      notifyListeners();
    }
  }
}
