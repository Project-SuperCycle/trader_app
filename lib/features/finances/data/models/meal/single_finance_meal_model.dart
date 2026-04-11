import 'meal_detailed_shipment_model.dart';

class SingleFinanceMealModel {
  final num amount;
  final String kind;
  final String settlementType;
  final String paymentStatus;
  final String paymentMethod;
  final int shipmentCount;
  final List<MealDetailedShipmentModel> shipments;

  // paid only
  final DateTime? paidAt;
  final String? confirmedByAdminId;
  final String? referenceNumber;
  final List<String>? paymentProof;
  final DateTime? createdAt;
  final String? paymentId;

  SingleFinanceMealModel({
    required this.amount,
    required this.kind,
    required this.settlementType,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.shipmentCount,
    required this.shipments,
    this.paidAt,
    this.confirmedByAdminId,
    this.referenceNumber,
    this.paymentProof,
    this.createdAt,
    this.paymentId,
  });

  factory SingleFinanceMealModel.fromJson(Map<String, dynamic> json) {
    return SingleFinanceMealModel(
      amount: json['amount'] as num,
      kind: json['kind'] as String,
      settlementType: json['settlementType'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      shipmentCount: json['shipmentCount'] as int,
      shipments: (json['shipments'] as List<dynamic>)
          .map(
            (e) =>
                MealDetailedShipmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
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
      'amount': amount,
      'kind': kind,
      'settlementType': settlementType,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'shipmentCount': shipmentCount,
      'shipments': shipments.map((e) => e.toJson()).toList(),
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
    return 'SingleFinanceMealModel(amount: $amount, kind: $kind, '
        'settlementType: $settlementType, paymentStatus: $paymentStatus, '
        'paymentMethod: $paymentMethod, shipmentCount: $shipmentCount, '
        'paidAt: $paidAt, paymentId: $paymentId)';
  }

  SingleFinanceMealModel copyWith({
    num? amount,
    String? kind,
    String? settlementType,
    String? paymentStatus,
    String? paymentMethod,
    int? shipmentCount,
    List<MealDetailedShipmentModel>? shipments,
    DateTime? paidAt,
    String? confirmedByAdminId,
    String? referenceNumber,
    List<String>? paymentProof,
    DateTime? createdAt,
    String? paymentId,
  }) {
    return SingleFinanceMealModel(
      amount: amount ?? this.amount,
      kind: kind ?? this.kind,
      settlementType: settlementType ?? this.settlementType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shipmentCount: shipmentCount ?? this.shipmentCount,
      shipments: shipments ?? this.shipments,
      paidAt: paidAt ?? this.paidAt,
      confirmedByAdminId: confirmedByAdminId ?? this.confirmedByAdminId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      paymentProof: paymentProof ?? this.paymentProof,
      createdAt: createdAt ?? this.createdAt,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid' || paymentStatus == 'confirmed';

  bool get isPending => paymentStatus == 'pending';

  bool get hasPaymentProof => paymentProof?.isNotEmpty ?? false;
}
