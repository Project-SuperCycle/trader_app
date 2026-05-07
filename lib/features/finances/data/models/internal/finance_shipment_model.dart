class FinanceShipmentModel {
  final String shipmentId;
  final String shipmentNumber;
  final DateTime weightedAt;
  final num totalWeightedKg;
  final num amount;
  final String paymentMethod;

  FinanceShipmentModel({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.weightedAt,
    required this.totalWeightedKg,
    required this.amount,
    required this.paymentMethod,
  });

  factory FinanceShipmentModel.fromJson(Map<String, dynamic> json) {
    return FinanceShipmentModel(
      shipmentId: json['shipmentId'] as String,
      shipmentNumber: json['shipmentNumber'] as String,
      weightedAt: DateTime.parse(json['weightedAt'] as String),
      totalWeightedKg: json['totalWeightedKg'] as num,
      amount: json['amount'] as num,
      paymentMethod: json['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipmentId': shipmentId,
      'shipmentNumber': shipmentNumber,
      'weightedAt': weightedAt.toIso8601String(),
      'totalWeightedKg': totalWeightedKg,
      'amount': amount,
      'paymentMethod': paymentMethod,
    };
  }

  FinanceShipmentModel copyWith({
    String? shipmentId,
    String? shipmentNumber,
    DateTime? weightedAt,
    num? totalWeightedKg,
    num? amount,
    String? paymentMethod,
  }) {
    return FinanceShipmentModel(
      shipmentId: shipmentId ?? this.shipmentId,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      weightedAt: weightedAt ?? this.weightedAt,
      totalWeightedKg: totalWeightedKg ?? this.totalWeightedKg,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  String toString() {
    return 'FinanceShipmentModel(shipmentId: $shipmentId, '
        'shipmentNumber: $shipmentNumber, weightedAt: $weightedAt, '
        'totalWeightedKg: $totalWeightedKg, amount: $amount, '
        'paymentMethod: $paymentMethod)';
  }
}
