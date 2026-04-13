import 'meal_shipment_item_model.dart';
import 'meal_shipment_segment_model.dart';
import 'meal_source_location_model.dart';

class MealDetailedShipmentModel {
  final String shipmentId;
  final String shipmentNumber;
  final DateTime requestedPickupAt;
  final num totalWeightedKg;
  final num amount;
  final String financeStatus;
  final String paymentMethod;
  final String sourceLocationId;
  final MealSourceLocationModel sourceLocation;
  final DateTime weightedAt;
  final String? userNotes;
  final List<String> uploadedImages;
  final List<MealShipmentItemModel> items;
  final List<MealShipmentSegmentModel> segments;

  MealDetailedShipmentModel({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.requestedPickupAt,
    required this.totalWeightedKg,
    required this.amount,
    required this.financeStatus,
    required this.paymentMethod,
    required this.sourceLocationId,
    required this.sourceLocation,
    required this.weightedAt,
    required this.uploadedImages,
    required this.items,
    required this.segments,
    this.userNotes,
  });

  factory MealDetailedShipmentModel.fromJson(Map<String, dynamic> json) {
    return MealDetailedShipmentModel(
      shipmentId: json['shipmentId'] as String,
      shipmentNumber: json['shipmentNumber'] as String,
      requestedPickupAt: DateTime.parse(json['requestedPickupAt'] as String),
      totalWeightedKg: json['totalWeightedKg'] as num,
      amount: json['amount'] as num,
      financeStatus: json['financeStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      sourceLocationId: json['sourceLocationId'] as String,
      sourceLocation: MealSourceLocationModel.fromJson(
        json['sourceLocation'] as Map<String, dynamic>,
      ),
      weightedAt: DateTime.parse(json['weightedAt'] as String),
      userNotes: json['userNotes'] as String?,
      uploadedImages: List<String>.from(json['uploadedImages'] ?? []),
      items: (json['items'] as List<dynamic>)
          .map((e) => MealShipmentItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      segments: (json['segments'] as List<dynamic>)
          .map(
            (e) => MealShipmentSegmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipmentId': shipmentId,
      'shipmentNumber': shipmentNumber,
      'requestedPickupAt': requestedPickupAt.toIso8601String(),
      'totalWeightedKg': totalWeightedKg,
      'amount': amount,
      'financeStatus': financeStatus,
      'paymentMethod': paymentMethod,
      'sourceLocationId': sourceLocationId,
      'sourceLocation': sourceLocation.toJson(),
      'weightedAt': weightedAt.toIso8601String(),
      'userNotes': userNotes,
      'uploadedImages': uploadedImages,
      'items': items.map((e) => e.toJson()).toList(),
      'segments': segments.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'MealDetailedShipmentModel(shipmentId: $shipmentId, '
        'shipmentNumber: $shipmentNumber, amount: $amount, '
        'financeStatus: $financeStatus, totalWeightedKg: $totalWeightedKg)';
  }

  MealDetailedShipmentModel copyWith({
    String? shipmentId,
    String? shipmentNumber,
    DateTime? requestedPickupAt,
    num? totalWeightedKg,
    num? amount,
    String? financeStatus,
    String? paymentMethod,
    String? sourceLocationId,
    MealSourceLocationModel? sourceLocation,
    DateTime? weightedAt,
    String? userNotes,
    List<String>? uploadedImages,
    List<MealShipmentItemModel>? items,
    List<MealShipmentSegmentModel>? segments,
  }) {
    return MealDetailedShipmentModel(
      shipmentId: shipmentId ?? this.shipmentId,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      requestedPickupAt: requestedPickupAt ?? this.requestedPickupAt,
      totalWeightedKg: totalWeightedKg ?? this.totalWeightedKg,
      amount: amount ?? this.amount,
      financeStatus: financeStatus ?? this.financeStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      sourceLocationId: sourceLocationId ?? this.sourceLocationId,
      sourceLocation: sourceLocation ?? this.sourceLocation,
      weightedAt: weightedAt ?? this.weightedAt,
      userNotes: userNotes ?? this.userNotes,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      items: items ?? this.items,
      segments: segments ?? this.segments,
    );
  }
}
