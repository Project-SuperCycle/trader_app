class PaidSummaryModel {
  final int payments;
  final int shipments;
  final num amount;
  final DateTime? lastPaidAt;

  PaidSummaryModel({
    required this.payments,
    required this.shipments,
    required this.amount,
    this.lastPaidAt,
  });

  factory PaidSummaryModel.fromJson(Map<String, dynamic> json) {
    return PaidSummaryModel(
      payments: json['payments'] as int,
      shipments: json['shipments'] as int,
      amount: json['amount'] as num,
      lastPaidAt: json['lastPaidAt'] != null
          ? DateTime.parse(json['lastPaidAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payments': payments,
      'shipments': shipments,
      'amount': amount,
      if (lastPaidAt != null) 'lastPaidAt': lastPaidAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'PaidSummaryModel(payments: $payments, shipments: $shipments, '
        'amount: $amount, lastPaidAt: $lastPaidAt)';
  }

  PaidSummaryModel copyWith({
    int? payments,
    int? shipments,
    num? amount,
    DateTime? lastPaidAt,
  }) {
    return PaidSummaryModel(
      payments: payments ?? this.payments,
      shipments: shipments ?? this.shipments,
      amount: amount ?? this.amount,
      lastPaidAt: lastPaidAt ?? this.lastPaidAt,
    );
  }
}
