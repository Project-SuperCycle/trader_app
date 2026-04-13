import 'external_segment_model.dart';

class SingleFinanceExternalModel {
  final String shipmentNumber;
  final num amount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final DateTime weightedAt;
  final num weight;
  final String? image;
  final List<String> paymentProof;
  final List<ExternalSegmentModel> segments;

  // null in pending, filled in paid
  final String? paymentId;
  final DateTime? paidAt;
  final String? referenceNumber;

  SingleFinanceExternalModel({
    required this.shipmentNumber,
    required this.amount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.weightedAt,
    required this.weight,
    required this.paymentProof,
    required this.segments,
    this.image,
    this.paymentId,
    this.paidAt,
    this.referenceNumber,
  });

  factory SingleFinanceExternalModel.fromJson(Map<String, dynamic> json) {
    return SingleFinanceExternalModel(
      shipmentNumber: json['shipmentNumber'] as String,
      amount: json['amount'] as num,
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      weightedAt: DateTime.parse(json['weightedAt'] as String),
      weight: json['weight'] as num,
      image: json['image'] as String?,
      paymentProof: List<String>.from(json['paymentProof'] ?? []),
      segments: (json['segments'] as List<dynamic>)
          .map((e) => ExternalSegmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentId: json['paymentId'] as String?,
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
      referenceNumber: json['referenceNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipmentNumber': shipmentNumber,
      'amount': amount,
      'status': status,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'weightedAt': weightedAt.toIso8601String(),
      'weight': weight,
      'image': image,
      'paymentProof': paymentProof,
      'segments': segments.map((e) => e.toJson()).toList(),
      'paymentId': paymentId,
      'paidAt': paidAt?.toIso8601String(),
      'referenceNumber': referenceNumber,
    };
  }

  @override
  String toString() {
    return 'SingleFinanceExternalModel(shipmentNumber: $shipmentNumber, amount: $amount, '
        'status: $status, paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, '
        'weightedAt: $weightedAt, weight: $weight, paymentId: $paymentId, '
        'paidAt: $paidAt, referenceNumber: $referenceNumber)';
  }

  SingleFinanceExternalModel copyWith({
    String? shipmentNumber,
    num? amount,
    String? status,
    String? paymentStatus,
    String? paymentMethod,
    DateTime? weightedAt,
    num? weight,
    String? image,
    List<String>? paymentProof,
    List<ExternalSegmentModel>? segments,
    String? paymentId,
    DateTime? paidAt,
    String? referenceNumber,
  }) {
    return SingleFinanceExternalModel(
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      weightedAt: weightedAt ?? this.weightedAt,
      weight: weight ?? this.weight,
      image: image ?? this.image,
      paymentProof: paymentProof ?? this.paymentProof,
      segments: segments ?? this.segments,
      paymentId: paymentId ?? this.paymentId,
      paidAt: paidAt ?? this.paidAt,
      referenceNumber: referenceNumber ?? this.referenceNumber,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid';

  bool get isPending => paymentStatus == 'pending';

  bool get hasPaymentProof => paymentProof.isNotEmpty;
}
