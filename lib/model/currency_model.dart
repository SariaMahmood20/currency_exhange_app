class CurrencyModel {
  final Map<String, String> currencies;

  CurrencyModel({
    required this.currencies,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      currencies: json.map((key, value) => MapEntry(key, value as String)),
    );
  }

  Map<String, dynamic> toJson() {
  return {'currencies': currencies};
}

  @override
  String toString() {
    return 'CurrencyModel{currencies: $currencies}';
  }
}
