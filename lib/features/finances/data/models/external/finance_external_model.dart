class FinanceExternalModel {
  final num totalWeightedKg;
  final DateTime requestedPickupAt;
  final DateTime createdAt;
  final String shipmentNumber;
  final String kind;
  final String settlementType;
  final String shipmentId;
  final num amount;
  final String paymentMethod;
  final String financeStatus;
  final String paymentStatus;
  final DateTime weightedAt;
  final DateTime? paidAt; // only in paid response
  final String viewType;

  FinanceExternalModel({
    required this.totalWeightedKg,
    required this.requestedPickupAt,
    required this.createdAt,
    required this.shipmentNumber,
    required this.kind,
    required this.settlementType,
    required this.shipmentId,
    required this.amount,
    required this.paymentMethod,
    required this.financeStatus,
    required this.paymentStatus,
    required this.weightedAt,
    this.paidAt,
    required this.viewType,
  });

  factory FinanceExternalModel.fromJson(Map<String, dynamic> json) {
    return FinanceExternalModel(
      totalWeightedKg: json['totalWeightedKg'] as num,
      requestedPickupAt: DateTime.parse(json['requestedPickupAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      shipmentNumber: json['shipmentNumber'] as String,
      kind: json['kind'] as String,
      settlementType: json['settlementType'] as String,
      shipmentId: json['shipmentId'] as String,
      amount: json['amount'] as num,
      paymentMethod: json['paymentMethod'] as String,
      financeStatus: json['financeStatus'] as String,
      paymentStatus: json['paymentStatus'] as String,
      weightedAt: DateTime.parse(json['weightedAt'] as String),
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
      viewType: json['viewType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalWeightedKg': totalWeightedKg,
      'requestedPickupAt': requestedPickupAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'shipmentNumber': shipmentNumber,
      'kind': kind,
      'settlementType': settlementType,
      'shipmentId': shipmentId,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'financeStatus': financeStatus,
      'paymentStatus': paymentStatus,
      'weightedAt': weightedAt.toIso8601String(),
      if (paidAt != null) 'paidAt': paidAt!.toIso8601String(),
      'viewType': viewType,
    };
  }

  @override
  String toString() {
    return 'FinanceExternalModel(shipmentNumber: $shipmentNumber, shipmentId: $shipmentId, '
        'amount: $amount, financeStatus: $financeStatus, paymentStatus: $paymentStatus, '
        'paidAt: $paidAt, viewType: $viewType)';
  }

  FinanceExternalModel copyWith({
    num? totalWeightedKg,
    DateTime? requestedPickupAt,
    DateTime? createdAt,
    String? shipmentNumber,
    String? kind,
    String? settlementType,
    String? shipmentId,
    num? amount,
    String? paymentMethod,
    String? financeStatus,
    String? paymentStatus,
    DateTime? weightedAt,
    DateTime? paidAt,
    String? viewType,
  }) {
    return FinanceExternalModel(
      totalWeightedKg: totalWeightedKg ?? this.totalWeightedKg,
      requestedPickupAt: requestedPickupAt ?? this.requestedPickupAt,
      createdAt: createdAt ?? this.createdAt,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      kind: kind ?? this.kind,
      settlementType: settlementType ?? this.settlementType,
      shipmentId: shipmentId ?? this.shipmentId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      financeStatus: financeStatus ?? this.financeStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      weightedAt: weightedAt ?? this.weightedAt,
      paidAt: paidAt ?? this.paidAt,
      viewType: viewType ?? this.viewType,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid';

  bool get isPending => paymentStatus == 'pending';
}
