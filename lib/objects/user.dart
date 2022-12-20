class User {
  late String uid;
  late bool canMakeTransactions;
  late bool isAdmin;

  User({
    required this.uid,
    this.canMakeTransactions = false,
    this.isAdmin = false,
  });

  User.fromMap({required Map<String, dynamic> map}) {
    uid = map['uid'];
    canMakeTransactions = map['can_make_transactions'];
    isAdmin = map['is_admin'];
  }
}
