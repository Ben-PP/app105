class Transaction {
  late String id;
  late String uid;
  late double amount;
  late DateTime dateTime;

  Transaction({
    required this.id,
    required this.uid,
    required this.amount,
    required this.dateTime,
  });

  Transaction.fromMap({required Map<String, dynamic> map}) {
    id = map['id'];
    uid = map['uid'];
    amount = map['amount'];
    dateTime = DateTime.parse(map['timestamp']);
  }
}
