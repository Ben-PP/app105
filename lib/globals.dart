class GlobalSizes {
  static const appBarHeight = 0.06;
  static const passwordLength = 3;
  static const uidLength = 1;
}

class GlobalTextChecks {
  static RegExp allowedUidCharacters = RegExp('[a-zA-ZäöÄÖåÅ-]');
  static RegExp allowedBudgetCharacters = RegExp('[0-9.]');
}
