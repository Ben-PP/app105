import './transaction.dart';

/// Budget stores users income and expenses
///
/// [uid] is the user to whom the budget belongs to
/// [uid] of empty string is reserved for public budgets.
class Budget {
  late String uid;
  late double income;
  late double expenses;
  late List<Transaction> transactions;

  Budget({
    required this.uid,
    required this.income,
    required this.expenses,
    required this.transactions,
  });
  Budget.fromMap({
    required Map<String, dynamic> map,
  }) {
    uid = map['uid'];
    income = map['income'];
    expenses = map['expenses'];
    transactions = map['transactions'] == null
        ? []
        : (map['transactions'] as List<dynamic>)
            .map((e) => Transaction.fromMap(map: e))
            .toList();
  }

  double get transactionBalance {
    double sum = 0;
    for (Transaction transaction in transactions) {
      sum += transaction.amount;
    }
    return sum;
  }

  double get totalPositive {
    double sum = income;
    for (Transaction transaction in transactions) {
      if (transaction.amount < 0) continue;
      sum += transaction.amount;
    }
    return sum;
  }

  double get totalNegative {
    // BUG These calculations are not working...
    double sum = expenses;
    for (Transaction transaction in transactions) {
      if (transaction.amount > 0) continue;
      sum += transaction.amount;
    }
    return sum;
  }

  double get balance {
    double sum = totalPositive - totalNegative;
    return sum;
  }

  @override
  String toString() {
    return {
      'uid': uid,
      'income': income,
      'expenses': expenses,
      'transactions': transactions,
    }.toString();
  }
}
