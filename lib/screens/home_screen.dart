import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactions();
    });
  }

  void _showEditTransactionDialog(
      BuildContext context, Transaction transaction) {
    final descriptionController =
        TextEditingController(text: transaction.description);
    final amountController =
        TextEditingController(text: transaction.amount.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedTransaction = Transaction(
                  id: transaction.id,
                  description: descriptionController.text,
                  amount: double.parse(amountController.text),
                  date: transaction.date,
                );
                Provider.of<TransactionProvider>(context, listen: false)
                    .updateTransaction(updatedTransaction);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MMAS Money Tracker'),
      ),
      body: Column(
        children: [
          // Tambahkan grafik lingkaran di sini
          if (transactionProvider.transactions.isNotEmpty)
            SizedBox(
              height: 200,
              child: ExpensePieChart(
                  transactions: transactionProvider.transactions),
            ),
          Expanded(
            child: transactionProvider.transactions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: transactionProvider.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction =
                          transactionProvider.transactions[index];
                      return ListTile(
                        title: Text(transaction.description),
                        subtitle: Text('${transaction.amount}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showEditTransactionDialog(
                                  context, transaction),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Provider.of<TransactionProvider>(context,
                                        listen: false)
                                    .deleteTransaction(transaction.id!);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan aksi untuk menambah transaksi
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
