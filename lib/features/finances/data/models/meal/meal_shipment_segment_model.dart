class MealShipmentSegmentModel {
  final String segmentId;
  final String destinationType;
  final String destinationId;
  final String vehicleId;
  final String status;
  final num actualWeightKg;
  final DateTime weighedAt;

  // NOTE: no items list in meal segments unlike monthly segments

  MealShipmentSegmentModel({
    required this.segmentId,
    required this.destinationType,
    required this.destinationId,
    required this.vehicleId,
    required this.status,
    required this.actualWeightKg,
    required this.weighedAt,
  });

  factory MealShipmentSegmentModel.fromJson(Map<String, dynamic> json) {
    return MealShipmentSegmentModel(
      segmentId: json['segmentId'] as String,
      destinationType: json['destinationType'] as String,
      destinationId: json['destinationId'] as String,
      vehicleId: json['vehicleId'] as String,
      status: json['status'] as String,
      actualWeightKg: json['actualWeightKg'] as num,
      weighedAt: DateTime.parse(json['weighedAt'] as String),
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
    };
  }

  @override
  String toString() {
    return 'MealShipmentSegmentModel(segmentId: $segmentId, '
        'destinationType: $destinationType, status: $status, '
        'actualWeightKg: $actualWeightKg, weighedAt: $weighedAt)';
  }

  MealShipmentSegmentModel copyWith({
    String? segmentId,
    String? destinationType,
    String? destinationId,
    String? vehicleId,
    String? status,
    num? actualWeightKg,
    DateTime? weighedAt,
  }) {
    return MealShipmentSegmentModel(
      segmentId: segmentId ?? this.segmentId,
      destinationType: destinationType ?? this.destinationType,
      destinationId: destinationId ?? this.destinationId,
      vehicleId: vehicleId ?? this.vehicleId,
      status: status ?? this.status,
      actualWeightKg: actualWeightKg ?? this.actualWeightKg,
      weighedAt: weighedAt ?? this.weighedAt,
    );
  }
}
