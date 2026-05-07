class PendingSummaryModel {
  final int shipments;
  final num amount;
  final int? months;

  PendingSummaryModel({
    required this.shipments,
    required this.amount,
    this.months,
  });

  factory PendingSummaryModel.fromJson(Map<String, dynamic> json) {
    return PendingSummaryModel(
      shipments: json['shipments'] as int,
      amount: json['amount'] as num,
      months: json['months'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipments': shipments,
      'amount': amount,
      if (months != null) 'months': months,
    };
  }

  @override
  String toString() {
    return 'PendingSummaryModel(shipments: $shipments, amount: $amount, months: $months)';
  }

  PendingSummaryModel copyWith({int? shipments, num? amount, int? months}) {
    return PendingSummaryModel(
      shipments: shipments ?? this.shipments,
      amount: amount ?? this.amount,
      months: months ?? this.months,
    );
  }
}
