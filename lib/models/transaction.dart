class Transaction {
  final int? id;
  final double amount;
  final String description;
  final DateTime date;
  final int categoryId;

  Transaction({
    this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'category_id': categoryId,
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      amount: map['amount'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      categoryId: map['category_id'],
    );
  }
}
