import 'package:trader_app/features/finances/data/models/internal/finance_shipment_model.dart';

class SingleFinanceInternalModel {
  final String? paymentId;
  final String paymentStatus;
  final String paymentMethod;
  final List<String>? paymentProof;
  final num totalAmount;
  final DateTime? paidAt;
  final List<FinanceShipmentModel> shipments;
  final DateTime? periodFrom;
  final DateTime? periodTo;
  final String? referenceNumber;

  SingleFinanceInternalModel({
    required this.paymentStatus,
    required this.paymentMethod,
    required this.totalAmount,
    required this.shipments,
    this.paymentId,
    this.paymentProof,
    this.paidAt,
    this.periodFrom,
    this.periodTo,
    this.referenceNumber,
  });

  factory SingleFinanceInternalModel.fromJson(Map<String, dynamic> json) {
    return SingleFinanceInternalModel(
      paymentId: json['paymentId'] as String?,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      paymentProof: json['paymentProof'] != null
          ? List<String>.from(json['paymentProof'])
          : null,
      totalAmount: (json['totalAmount'] ?? json['amount']) as num,
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
      shipments: (json['shipments'] as List<dynamic>)
          .map((e) => FinanceShipmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      periodFrom: json['periodFrom'] != null
          ? DateTime.parse(json['periodFrom'] as String)
          : null,
      periodTo: json['periodTo'] != null
          ? DateTime.parse(json['periodTo'] as String)
          : null,
      referenceNumber: json['referenceNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (paymentId != null) 'paymentId': paymentId,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      if (paymentProof != null) 'paymentProof': paymentProof,
      'totalAmount': totalAmount,
      if (paidAt != null) 'paidAt': paidAt!.toIso8601String(),
      'shipments': shipments.map((e) => e.toJson()).toList(),
      if (periodFrom != null) 'periodFrom': periodFrom!.toIso8601String(),
      if (periodTo != null) 'periodTo': periodTo!.toIso8601String(),
      if (referenceNumber != null) 'referenceNumber': referenceNumber,
    };
  }

  SingleFinanceInternalModel copyWith({
    String? paymentId,
    String? paymentStatus,
    String? paymentMethod,
    List<String>? paymentProof,
    num? totalAmount,
    DateTime? paidAt,
    List<FinanceShipmentModel>? shipments,
    DateTime? periodFrom,
    DateTime? periodTo,
    String? referenceNumber,
  }) {
    return SingleFinanceInternalModel(
      paymentId: paymentId ?? this.paymentId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentProof: paymentProof ?? this.paymentProof,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAt: paidAt ?? this.paidAt,
      shipments: shipments ?? this.shipments,
      periodFrom: periodFrom ?? this.periodFrom,
      periodTo: periodTo ?? this.periodTo,
      referenceNumber: referenceNumber ?? this.referenceNumber,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid' || paymentStatus == 'confirmed';

  bool get isPending => paymentStatus == 'pending';

  bool get hasPaymentProof => paymentProof?.isNotEmpty ?? false;

  @override
  String toString() {
    return 'SingleFinanceInternalModel(paymentId: $paymentId, '
        'paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, '
        'totalAmount: $totalAmount, paidAt: $paidAt, '
        'shipmentsCount: ${shipments.length}, periodFrom: $periodFrom, '
        'periodTo: $periodTo, referenceNumber: $referenceNumber)';
  }
}
