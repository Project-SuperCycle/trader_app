import 'monthly_detailed_shipment_model.dart';

class SingleFinanceMonthlyModel {
  final String kind;
  final String settlementType;
  final String paymentStatus;
  final String paymentMethod;
  final num totalAmount;
  final int shipmentCount;
  final DateTime periodFrom;
  final DateTime periodTo;
  final List<MonthlyDetailedShipmentModel> shipments;
  final String viewType;

  // pending only
  final String? periodKey;
  final String? periodLabel;

  // paid only
  final DateTime? paidAt;
  final String? confirmedByAdminId;
  final String? referenceNumber;
  final List<String>? paymentProof;
  final DateTime? createdAt;
  final String? paymentId;

  SingleFinanceMonthlyModel({
    required this.kind,
    required this.settlementType,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.totalAmount,
    required this.shipmentCount,
    required this.periodFrom,
    required this.periodTo,
    required this.shipments,
    required this.viewType,
    this.periodKey,
    this.periodLabel,
    this.paidAt,
    this.confirmedByAdminId,
    this.referenceNumber,
    this.paymentProof,
    this.createdAt,
    this.paymentId,
  });

  factory SingleFinanceMonthlyModel.fromJson(Map<String, dynamic> json) {
    return SingleFinanceMonthlyModel(
      kind: json['kind'] as String,
      settlementType: json['settlementType'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      totalAmount: json['totalAmount'] as num,
      shipmentCount: json['shipmentCount'] as int,
      periodFrom: DateTime.parse(json['periodFrom'] as String),
      periodTo: DateTime.parse(json['periodTo'] as String),
      shipments: (json['shipments'] as List<dynamic>)
          .map(
            (e) => MonthlyDetailedShipmentModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      viewType: json['viewType'] as String,
      // pending only
      periodKey: json['periodKey'] as String?,
      periodLabel: json['periodLabel'] as String?,
      // paid only
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
      confirmedByAdminId: json['confirmedByAdminId'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
      paymentProof: json['paymentProof'] != null
          ? List<String>.from(json['paymentProof'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      paymentId: json['paymentId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kind': kind,
      'settlementType': settlementType,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'shipmentCount': shipmentCount,
      'periodFrom': periodFrom.toIso8601String(),
      'periodTo': periodTo.toIso8601String(),
      'shipments': shipments.map((e) => e.toJson()).toList(),
      'viewType': viewType,
      if (periodKey != null) 'periodKey': periodKey,
      if (periodLabel != null) 'periodLabel': periodLabel,
      if (paidAt != null) 'paidAt': paidAt!.toIso8601String(),
      if (confirmedByAdminId != null) 'confirmedByAdminId': confirmedByAdminId,
      if (referenceNumber != null) 'referenceNumber': referenceNumber,
      if (paymentProof != null) 'paymentProof': paymentProof,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (paymentId != null) 'paymentId': paymentId,
    };
  }

  @override
  String toString() {
    return 'SingleFinanceMonthlyModel(kind: $kind, settlementType: $settlementType, '
        'paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, '
        'totalAmount: $totalAmount, shipmentCount: $shipmentCount, '
        'periodFrom: $periodFrom, periodTo: $periodTo, '
        'periodKey: $periodKey, paidAt: $paidAt, paymentId: $paymentId)';
  }

  SingleFinanceMonthlyModel copyWith({
    String? kind,
    String? settlementType,
    String? paymentStatus,
    String? paymentMethod,
    num? totalAmount,
    int? shipmentCount,
    DateTime? periodFrom,
    DateTime? periodTo,
    List<MonthlyDetailedShipmentModel>? shipments,
    String? viewType,
    String? periodKey,
    String? periodLabel,
    DateTime? paidAt,
    String? confirmedByAdminId,
    String? referenceNumber,
    List<String>? paymentProof,
    DateTime? createdAt,
    String? paymentId,
  }) {
    return SingleFinanceMonthlyModel(
      kind: kind ?? this.kind,
      settlementType: settlementType ?? this.settlementType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      shipmentCount: shipmentCount ?? this.shipmentCount,
      periodFrom: periodFrom ?? this.periodFrom,
      periodTo: periodTo ?? this.periodTo,
      shipments: shipments ?? this.shipments,
      viewType: viewType ?? this.viewType,
      periodKey: periodKey ?? this.periodKey,
      periodLabel: periodLabel ?? this.periodLabel,
      paidAt: paidAt ?? this.paidAt,
      confirmedByAdminId: confirmedByAdminId ?? this.confirmedByAdminId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      paymentProof: paymentProof ?? this.paymentProof,
      createdAt: createdAt ?? this.createdAt,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid';

  bool get isPending => paymentStatus == 'pending';

  bool get hasPaymentProof => paymentProof?.isNotEmpty ?? false;
}
