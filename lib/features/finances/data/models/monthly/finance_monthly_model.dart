import 'package:trader_app/features/finances/data/models/monthly/monthly_shipment_model.dart';

class FinanceMonthlyModel {
  final num totalAmount;
  final String paymentMethod;
  final int shipmentCount;
  final DateTime periodFrom;
  final DateTime periodTo;
  final List<MonthlyShipmentModel> shipments;
  final String kind;
  final String settlementType;
  final String paymentStatus;
  final String viewType;

  // pending only
  final String? periodKey;
  final String? periodLabel;

  // paid only
  final DateTime? paidAt;
  final String? referenceNumber;
  final DateTime? createdAt;
  final String? paymentId;

  FinanceMonthlyModel({
    required this.totalAmount,
    required this.paymentMethod,
    required this.shipmentCount,
    required this.periodFrom,
    required this.periodTo,
    required this.shipments,
    required this.kind,
    required this.settlementType,
    required this.paymentStatus,
    required this.viewType,
    this.periodKey,
    this.periodLabel,
    this.paidAt,
    this.referenceNumber,
    this.createdAt,
    this.paymentId,
  });

  factory FinanceMonthlyModel.fromJson(Map<String, dynamic> json) {
    return FinanceMonthlyModel(
      totalAmount: json['totalAmount'] as num,
      paymentMethod: json['paymentMethod'] as String,
      shipmentCount: json['shipmentCount'] as int,
      periodFrom: DateTime.parse(json['periodFrom'] as String),
      periodTo: DateTime.parse(json['periodTo'] as String),
      shipments: (json['shipments'] as List<dynamic>)
          .map((e) => MonthlyShipmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      kind: json['kind'] as String,
      settlementType: json['settlementType'] as String,
      paymentStatus: json['paymentStatus'] as String,
      viewType: json['viewType'] as String,
      // pending only
      periodKey: json['periodKey'] as String?,
      periodLabel: json['periodLabel'] as String?,
      // paid only
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
      referenceNumber: json['referenceNumber'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      paymentId: json['paymentId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'shipmentCount': shipmentCount,
      'periodFrom': periodFrom.toIso8601String(),
      'periodTo': periodTo.toIso8601String(),
      'shipments': shipments.map((e) => e.toJson()).toList(),
      'kind': kind,
      'settlementType': settlementType,
      'paymentStatus': paymentStatus,
      'viewType': viewType,
      if (periodKey != null) 'periodKey': periodKey,
      if (periodLabel != null) 'periodLabel': periodLabel,
      if (paidAt != null) 'paidAt': paidAt!.toIso8601String(),
      if (referenceNumber != null) 'referenceNumber': referenceNumber,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (paymentId != null) 'paymentId': paymentId,
    };
  }

  @override
  String toString() {
    return 'FinanceMonthlyModel(totalAmount: $totalAmount, paymentMethod: $paymentMethod, '
        'shipmentCount: $shipmentCount, periodFrom: $periodFrom, periodTo: $periodTo, '
        'paymentStatus: $paymentStatus, periodKey: $periodKey, paidAt: $paidAt, '
        'paymentId: $paymentId, viewType: $viewType)';
  }

  FinanceMonthlyModel copyWith({
    num? totalAmount,
    String? paymentMethod,
    int? shipmentCount,
    DateTime? periodFrom,
    DateTime? periodTo,
    List<MonthlyShipmentModel>? shipments,
    String? kind,
    String? settlementType,
    String? paymentStatus,
    String? viewType,
    String? periodKey,
    String? periodLabel,
    DateTime? paidAt,
    String? referenceNumber,
    DateTime? createdAt,
    String? paymentId,
  }) {
    return FinanceMonthlyModel(
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shipmentCount: shipmentCount ?? this.shipmentCount,
      periodFrom: periodFrom ?? this.periodFrom,
      periodTo: periodTo ?? this.periodTo,
      shipments: shipments ?? this.shipments,
      kind: kind ?? this.kind,
      settlementType: settlementType ?? this.settlementType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      viewType: viewType ?? this.viewType,
      periodKey: periodKey ?? this.periodKey,
      periodLabel: periodLabel ?? this.periodLabel,
      paidAt: paidAt ?? this.paidAt,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      createdAt: createdAt ?? this.createdAt,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid';

  bool get isPending => paymentStatus == 'pending';
}

// --------------------------------------------------
