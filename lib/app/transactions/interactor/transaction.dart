class Transaction {
  final String type;
  final String label;
  final double amount;
  final DateTime date;

  Transaction({
    required this.type,
    required this.label,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'],
      label: json['label'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'label': label,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Transaction(type: $type, label: $label, amount: $amount, date: $date)';
  }
}
