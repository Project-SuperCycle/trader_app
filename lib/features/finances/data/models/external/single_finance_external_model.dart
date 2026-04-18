import 'external_Item_model.dart';

class SingleFinanceExternalModel {
  final String shipmentNumber;

  final String paymentId;
  final num amount;
  final String paymentStatus;
  final String paymentMethod;
  final DateTime weightedAt;
  final num weight;
  final List<String> paymentProof;
  final List<ExternalItemModel> items;
  final DateTime? paidAt;

  SingleFinanceExternalModel({
    required this.shipmentNumber,
    required this.paymentId,
    required this.amount,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.weightedAt,
    required this.weight,
    required this.paymentProof,
    required this.items,
    this.paidAt,
  });

  factory SingleFinanceExternalModel.fromJson(Map<String, dynamic> json) {
    // Flatten all items from all segments into a single list
    final segments = json['segments'] as List<dynamic>? ?? [];
    final items = segments
        .expand(
          (segment) =>
              (segment as Map<String, dynamic>)['items'] as List<dynamic>? ??
              [],
        )
        .map((e) => ExternalItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return SingleFinanceExternalModel(
      shipmentNumber: json['shipmentNumber'] as String,
      amount: json['amount'] as num,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      paymentId: json['paymentId'] as String,
      weightedAt: DateTime.parse(json['weightedAt'] as String),
      weight: json['weight'] as num,
      paymentProof: List<String>.from(json['paymentProof'] ?? []),
      items: items,
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipmentNumber': shipmentNumber,
      'amount': amount,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'paymentId': paymentId,
      'weightedAt': weightedAt.toIso8601String(),
      'weight': weight,
      'paymentProof': paymentProof,
      'items': items.map((e) => e.toJson()).toList(),
      if (paidAt != null) 'paidAt': paidAt!.toIso8601String(),
    };
  }

  SingleFinanceExternalModel copyWith({
    String? shipmentNumber,
    num? amount,
    String? paymentStatus,
    String? paymentMethod,
    String? paymentId,
    DateTime? weightedAt,
    num? weight,
    List<String>? paymentProof,
    List<ExternalItemModel>? items,
    DateTime? paidAt,
  }) {
    return SingleFinanceExternalModel(
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      amount: amount ?? this.amount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      weightedAt: weightedAt ?? this.weightedAt,
      weight: weight ?? this.weight,
      paymentProof: paymentProof ?? this.paymentProof,
      items: items ?? this.items,
      paidAt: paidAt ?? this.paidAt,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  // Helper getters
  bool get isPaid => paymentStatus == 'paid';

  bool get isPending => paymentStatus == 'pending';

  bool get hasPaymentProof => paymentProof.isNotEmpty;

  @override
  String toString() {
    return 'SingleFinanceExternalModel(shipmentNumber: $shipmentNumber, amount: $amount, '
        'paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, '
        'weightedAt: $weightedAt, weight: $weight, '
        'itemsCount: ${items.length}, paidAt: $paidAt)';
  }
}
