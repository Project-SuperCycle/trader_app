import 'monthly_shipment_item_model.dart';

class MonthlyShipmentSegmentModel {
  final String segmentId;
  final String destinationType;
  final String destinationId;
  final String vehicleId;
  final String status;
  final num actualWeightKg;
  final DateTime weighedAt;
  final List<MonthlyShipmentItemModel> items;

  MonthlyShipmentSegmentModel({
    required this.segmentId,
    required this.destinationType,
    required this.destinationId,
    required this.vehicleId,
    required this.status,
    required this.actualWeightKg,
    required this.weighedAt,
    required this.items,
  });

  factory MonthlyShipmentSegmentModel.fromJson(Map<String, dynamic> json) {
    return MonthlyShipmentSegmentModel(
      segmentId: json['segmentId'] as String,
      destinationType: json['destinationType'] as String,
      destinationId: json['destinationId'] as String,
      vehicleId: json['vehicleId'] as String,
      status: json['status'] as String,
      actualWeightKg: json['actualWeightKg'] as num,
      weighedAt: DateTime.parse(json['weighedAt'] as String),
      items: (json['items'] as List<dynamic>)
          .map(
            (e) => MonthlyShipmentItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'segmentId': segmentId,
      'destinationType': destinationType,
      'destinationId': destinationId,
      'vehicleId': vehicleId,
      'status': status,
      'actualWeightKg': actualWeightKg,
      'weighedAt': weighedAt.toIso8601String(),
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'MonthlyShipmentSegmentModel(segmentId: $segmentId, '
        'destinationType: $destinationType, status: $status, '
        'actualWeightKg: $actualWeightKg, weighedAt: $weighedAt)';
  }

  MonthlyShipmentSegmentModel copyWith({
    String? segmentId,
    String? destinationType,
    String? destinationId,
    String? vehicleId,
    String? status,
    num? actualWeightKg,
    DateTime? weighedAt,
    List<MonthlyShipmentItemModel>? items,
  }) {
    return MonthlyShipmentSegmentModel(
      segmentId: segmentId ?? this.segmentId,
      destinationType: destinationType ?? this.destinationType,
      destinationId: destinationId ?? this.destinationId,
      vehicleId: vehicleId ?? this.vehicleId,
      status: status ?? this.status,
      actualWeightKg: actualWeightKg ?? this.actualWeightKg,
      weighedAt: weighedAt ?? this.weighedAt,
      items: items ?? this.items,
    );
  }
}
