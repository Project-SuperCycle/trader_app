class MealShipmentModel {
  final String shipmentId;
  final String shipmentNumber;
  final DateTime requestedPickupAt;
  final num totalWeightedKg;
  final num amount;
  final String financeStatus;

  MealShipmentModel({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.requestedPickupAt,
    required this.totalWeightedKg,
    required this.amount,
    required this.financeStatus,
  });

  factory MealShipmentModel.fromJson(Map<String, dynamic> json) {
    return MealShipmentModel(
      shipmentId: json['shipmentId'] as String,
      shipmentNumber: json['shipmentNumber'] as String,
      requestedPickupAt: DateTime.parse(json['requestedPickupAt'] as String),
      totalWeightedKg: json['totalWeightedKg'] as num,
      amount: json['amount'] as num,
      financeStatus: json['financeStatus'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipmentId': shipmentId,
      'shipmentNumber': shipmentNumber,
      'requestedPickupAt': requestedPickupAt.toIso8601String(),
      'totalWeightedKg': totalWeightedKg,
      'amount': amount,
      'financeStatus': financeStatus,
    };
  }

  @override
  String toString() {
    return 'MealShipmentModel(shipmentId: $shipmentId, shipmentNumber: $shipmentNumber, '
        'requestedPickupAt: $requestedPickupAt, totalWeightedKg: $totalWeightedKg, '
        'amount: $amount, financeStatus: $financeStatus)';
  }

  MealShipmentModel copyWith({
    String? shipmentId,
    String? shipmentNumber,
    DateTime? requestedPickupAt,
    num? totalWeightedKg,
    num? amount,
    String? financeStatus,
  }) {
    return MealShipmentModel(
      shipmentId: shipmentId ?? this.shipmentId,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      requestedPickupAt: requestedPickupAt ?? this.requestedPickupAt,
      totalWeightedKg: totalWeightedKg ?? this.totalWeightedKg,
      amount: amount ?? this.amount,
      financeStatus: financeStatus ?? this.financeStatus,
    );
  }
}
