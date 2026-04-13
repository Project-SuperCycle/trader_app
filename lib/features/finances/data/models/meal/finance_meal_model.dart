import 'meal_shipment_model.dart';

class FinanceMealModel {
  final num amount;
  final String kind;
  final String settlementType;
  final String paymentStatus;
  final String paymentMethod;
  final String viewType;
  final DateTime createdAt;

  // pending only (individual shipment fields)
  final num? totalWeightedKg;
  final DateTime? requestedPickupAt;
  final String? shipmentNumber;
  final String? shipmentId;
  final String? financeStatus;
  final DateTime? weightedAt;

  // paid only (payment group fields)
  final DateTime? paidAt;
  final String? referenceNumber;
  final String? paymentId;
  final int? shipmentCount;
  final List<MealShipmentModel>? shipments;

  FinanceMealModel({
    required this.amount,
    required this.kind,
    required this.settlementType,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.viewType,
    required this.createdAt,
    // pending only
    this.totalWeightedKg,
    this.requestedPickupAt,
    this.shipmentNumber,
    this.shipmentId,
    this.financeStatus,
    this.weightedAt,
    // paid only
    this.paidAt,
    this.referenceNumber,
    this.paymentId,
    this.shipmentCount,
    this.shipments,
  });

  factory FinanceMealModel.fromJson(Map<String, dynamic> json) {
    return FinanceMealModel(
      amount: json['amount'] as num,
      kind: json['kind'] as String,
      settlementType: json['settlementType'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      viewType: json['viewType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      // pending only
      totalWeightedKg: json['totalWeightedKg'] as num?,
      requestedPickupAt: json['requestedPickupAt'] != null
          ? DateTime.parse(json['requestedPickupAt'] as String)
          : null,
      shipmentNumber: json['shipmentNumber'] as String?,
      shipmentId: json['shipmentId'] as String?,
      financeStatus: json['financeStatus'] as String?,
      weightedAt: json['weightedAt'] != null
          ? DateTime.parse(json['weightedAt'] as String)
          : null,
      // paid only
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
      referenceNumber: json['referenceNumber'] as String?,
      paymentId: json['paymentId'] as String?,
      shipmentCount: json['shipmentCount'] as int?,
      shipments: json['shipments'] != null
          ? (json['shipments'] as List<dynamic>)
                .map(
                  (e) => MealShipmentModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'kind': kind,
      'settlementType': settlementType,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'viewType': viewType,
      'createdAt': createdAt.toIso8601String(),
      if (totalWeightedKg != null) 'totalWeightedKg': totalWeightedKg,
      if (requestedPickupAt != null)
        'requestedPickupAt': requestedPickupAt!.toIso8601String(),
      if (shipmentNumber != null) 'shipmentNumber': shipmentNumber,
      if (shipmentId != null) 'shipmentId': shipmentId,
      if (financeStatus != null) 'financeStatus': financeStatus,
      if (weightedAt != null) 'weightedAt': weightedAt!.toIso8601String(),
      if (paidAt != null) 'paidAt': paidAt!.toIso8601String(),
      if (referenceNumber != null) 'referenceNumber': referenceNumber,
      if (paymentId != null) 'paymentId': paymentId,
      if (shipmentCount != null) 'shipmentCount': shipmentCount,
      if (shipments != null)
        'shipments': shipments!.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'FinanceMealModel(amount: $amount, kind: $kind, settlementType: $settlementType, '
        'paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, '
        'shipmentNumber: $shipmentNumber, shipmentId: $shipmentId, '
        'financeStatus: $financeStatus, paidAt: $paidAt, paymentId: $paymentId, '
        'shipmentCount: $shipmentCount, viewType: $viewType)';
  }

  FinanceMealModel copyWith({
    num? amount,
    String? kind,
    String? settlementType,
    String? paymentStatus,
    String? paymentMethod,
    String? viewType,
    DateTime? createdAt,
    num? totalWeightedKg,
    DateTime? requestedPickupAt,
    String? shipmentNumber,
    String? shipmentId,
    String? financeStatus,
    DateTime? weightedAt,
    DateTime? paidAt,
    String? referenceNumber,
    String? paymentId,
    int? shipmentCount,
    List<MealShipmentModel>? shipments,
  }) {
    return FinanceMealModel(
      amount: amount ?? this.amount,
      kind: kind ?? this.kind,
      settlementType: settlementType ?? this.settlementType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      viewType: viewType ?? this.viewType,
      createdAt: createdAt ?? this.createdAt,
      totalWeightedKg: totalWeightedKg ?? this.totalWeightedKg,
      requestedPickupAt: requestedPickupAt ?? this.requestedPickupAt,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      shipmentId: shipmentId ?? this.shipmentId,
      financeStatus: financeStatus ?? this.financeStatus,
      weightedAt: weightedAt ?? this.weightedAt,
      paidAt: paidAt ?? this.paidAt,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      paymentId: paymentId ?? this.paymentId,
      shipmentCount: shipmentCount ?? this.shipmentCount,
      shipments: shipments ?? this.shipments,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid';

  bool get isPending => paymentStatus == 'pending';
}

// --------------------------------------------------
