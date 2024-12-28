class EuroCurrencyModel {
  final DateTime date;
  final Map<String, double> eur;

  EuroCurrencyModel({
    required this.date,
    required this.eur,
  });

  EuroCurrencyModel copyWith({
    DateTime? date,
    Map<String, double>? eur,
  }) =>
      EuroCurrencyModel(
        date: date ?? this.date,
        eur: eur ?? this.eur,
      );

  factory EuroCurrencyModel.fromJson(Map<String, dynamic> json) {
    return EuroCurrencyModel(
      date: DateTime.parse(json['date']),
      eur: Map<String, double>.from(json['eur']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'eur': eur,
    };
  }
}
