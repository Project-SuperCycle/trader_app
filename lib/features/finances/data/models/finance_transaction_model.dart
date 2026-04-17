class FinanceTransactionModel {
  final String settlementType;
  final String viewType;
  final String? shipmentId;
  final String? paymentId;
  final String paymentMethod;
  final String paymentStatus;
  final num amount;
  final DateTime? weightedAt;
  final DateTime? paidAt;
  final DateTime? periodFrom;
  final DateTime? periodTo;
  final num totalWeightedKg;

  FinanceTransactionModel({
    required this.settlementType,
    required this.viewType,
    this.shipmentId,
    this.paymentId,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.amount,
    this.weightedAt,
    this.paidAt,
    this.periodFrom,
    this.periodTo,
    required this.totalWeightedKg,
  });

  factory FinanceTransactionModel.fromJson(Map<String, dynamic> json) {
    // Calculate totalWeightedKg from shipments if not directly provided
    num resolvedTotalWeightedKg;
    if (json['totalWeightedKg'] != null) {
      resolvedTotalWeightedKg = json['totalWeightedKg'] as num;
    } else if (json['shipments'] != null) {
      final shipments = json['shipments'] as List<dynamic>;
      resolvedTotalWeightedKg = shipments.fold<num>(
        0,
        (sum, e) =>
            sum + ((e as Map<String, dynamic>)['totalWeightedKg'] as num? ?? 0),
      );
    } else {
      resolvedTotalWeightedKg = 0;
    }

    return FinanceTransactionModel(
      settlementType: json['settlementType'] as String,
      viewType: json['viewType'] as String,
      shipmentId: json['shipmentId'] as String?,
      paymentId: json['paymentId'] as String?,
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String,
      amount: json['amount'] != null
          ? json['amount'] as num
          : json['totalAmount'] as num,
      weightedAt: json['weightedAt'] != null
          ? DateTime.parse(json['weightedAt'] as String)
          : null,
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
      periodFrom: json['periodFrom'] != null
          ? DateTime.parse(json['periodFrom'] as String)
          : null,
      periodTo: json['periodTo'] != null
          ? DateTime.parse(json['periodTo'] as String)
          : null,
      totalWeightedKg: resolvedTotalWeightedKg,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'settlementType': settlementType,
      'viewType': viewType,
      if (shipmentId != null) 'shipmentId': shipmentId,
      if (paymentId != null) 'paymentId': paymentId,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'amount': amount,
      if (weightedAt != null) 'weightedAt': weightedAt!.toIso8601String(),
      if (paidAt != null) 'paidAt': paidAt!.toIso8601String(),
      if (periodFrom != null) 'periodFrom': periodFrom!.toIso8601String(),
      if (periodTo != null) 'periodTo': periodTo!.toIso8601String(),
      'totalWeightedKg': totalWeightedKg,
    };
  }

  FinanceTransactionModel copyWith({
    String? settlementType,
    String? viewType,
    String? shipmentId,
    String? paymentId,
    String? paymentMethod,
    String? paymentStatus,
    num? amount,
    num? totalAmount,
    DateTime? weightedAt,
    DateTime? paidAt,
    DateTime? periodFrom,
    DateTime? periodTo,
    num? totalWeightedKg,
  }) {
    return FinanceTransactionModel(
      settlementType: settlementType ?? this.settlementType,
      viewType: viewType ?? this.viewType,
      shipmentId: shipmentId ?? this.shipmentId,
      paymentId: paymentId ?? this.paymentId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      amount: amount ?? this.amount,
      weightedAt: weightedAt ?? this.weightedAt,
      paidAt: paidAt ?? this.paidAt,
      periodFrom: periodFrom ?? this.periodFrom,
      periodTo: periodTo ?? this.periodTo,
      totalWeightedKg: totalWeightedKg ?? this.totalWeightedKg,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid';

  bool get isPending => paymentStatus == 'pending';

  @override
  String toString() {
    return 'FinanceTransactionModel(settlementType: $settlementType, viewType: $viewType, '
        'shipmentId: $shipmentId, paymentId: $paymentId, paymentMethod: $paymentMethod, '
        'paymentStatus: $paymentStatus, amount: $amount,'
        'weightedAt: $weightedAt, paidAt: $paidAt, periodFrom: $periodFrom, '
        'periodTo: $periodTo, totalWeightedKg: $totalWeightedKg)';
  }
}
