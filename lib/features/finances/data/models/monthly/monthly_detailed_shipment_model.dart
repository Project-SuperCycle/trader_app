import 'monthly_shipment_item_model.dart';
import 'monthly_shipment_segment_model.dart';
import 'monthly_source_location_model.dart';

class MonthlyDetailedShipmentModel {
  final String shipmentId;
  final String shipmentNumber;
  final DateTime requestedPickupAt;
  final num totalWeightedKg;
  final num amount;
  final String financeStatus;
  final String paymentMethod;
  final DateTime weightedAt;
  final String sourceLocationId;
  final MonthlySourceLocationModel sourceLocation;
  final String? userNotes;
  final List<String> uploadedImages;
  final DateTime createdAt;
  final List<MonthlyShipmentItemModel> items;
  final List<MonthlyShipmentSegmentModel> segments;

  MonthlyDetailedShipmentModel({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.requestedPickupAt,
    required this.totalWeightedKg,
    required this.amount,
    required this.financeStatus,
    required this.paymentMethod,
    required this.weightedAt,
    required this.sourceLocationId,
    required this.sourceLocation,
    required this.uploadedImages,
    required this.createdAt,
    required this.items,
    required this.segments,
    this.userNotes,
  });

  factory MonthlyDetailedShipmentModel.fromJson(Map<String, dynamic> json) {
    return MonthlyDetailedShipmentModel(
      shipmentId: json['shipmentId'] as String,
      shipmentNumber: json['shipmentNumber'] as String,
      requestedPickupAt: DateTime.parse(json['requestedPickupAt'] as String),
      totalWeightedKg: json['totalWeightedKg'] as num,
      amount: json['amount'] as num,
      financeStatus: json['financeStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      weightedAt: DateTime.parse(json['weightedAt'] as String),
      sourceLocationId: json['sourceLocationId'] as String,
      sourceLocation: MonthlySourceLocationModel.fromJson(
        json['sourceLocation'] as Map<String, dynamic>,
      ),
      userNotes: json['userNotes'] as String?,
      uploadedImages: List<String>.from(json['uploadedImages'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      items: (json['items'] as List<dynamic>)
          .map(
            (e) => MonthlyShipmentItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      segments: (json['segments'] as List<dynamic>)
          .map(
            (e) =>
                MonthlyShipmentSegmentModel.fromJson(e as Map<String, dynamic>),
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
      'weightedAt': weightedAt.toIso8601String(),
      'sourceLocationId': sourceLocationId,
      'sourceLocation': sourceLocation.toJson(),
      'userNotes': userNotes,
      'uploadedImages': uploadedImages,
      'createdAt': createdAt.toIso8601String(),
      'items': items.map((e) => e.toJson()).toList(),
      'segments': segments.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'MonthlyDetailedShipmentModel(shipmentId: $shipmentId, '
        'shipmentNumber: $shipmentNumber, amount: $amount, '
        'financeStatus: $financeStatus, totalWeightedKg: $totalWeightedKg)';
  }

  MonthlyDetailedShipmentModel copyWith({
    String? shipmentId,
    String? shipmentNumber,
    DateTime? requestedPickupAt,
    num? totalWeightedKg,
    num? amount,
    String? financeStatus,
    String? paymentMethod,
    DateTime? weightedAt,
    String? sourceLocationId,
    MonthlySourceLocationModel? sourceLocation,
    String? userNotes,
    List<String>? uploadedImages,
    DateTime? createdAt,
    List<MonthlyShipmentItemModel>? items,
    List<MonthlyShipmentSegmentModel>? segments,
  }) {
    return MonthlyDetailedShipmentModel(
      shipmentId: shipmentId ?? this.shipmentId,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      requestedPickupAt: requestedPickupAt ?? this.requestedPickupAt,
      totalWeightedKg: totalWeightedKg ?? this.totalWeightedKg,
      amount: amount ?? this.amount,
      financeStatus: financeStatus ?? this.financeStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      weightedAt: weightedAt ?? this.weightedAt,
      sourceLocationId: sourceLocationId ?? this.sourceLocationId,
      sourceLocation: sourceLocation ?? this.sourceLocation,
      userNotes: userNotes ?? this.userNotes,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
      segments: segments ?? this.segments,
    );
  }
}
