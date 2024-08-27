// ignore: camel_case_types
enum TRANSACTION_TYPE { payment, topUp }

class Transaction {
  final TRANSACTION_TYPE type;
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
      type: parseTransactionType(json['type']),
      label: json['label'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'label': label,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  static TRANSACTION_TYPE parseTransactionType(String typeName) {
    final TRANSACTION_TYPE type = TRANSACTION_TYPE.values.firstWhere(
      (e) {
        return e.name.toLowerCase() == typeName.toLowerCase();
      },
    );
    return type;
  }

  @override
  String toString() {
    return 'Transaction(type: $type, label: $label, amount: $amount, date: $date)';
  }
}
