import 'external_segment_Item_model.dart';

class ExternalSegmentModel {
  final String segmentId;
  final String status;
  final num weight;
  final DateTime weighedAt;
  final List<String> images;
  final List<ExternalSegmentItemModel> items;

  ExternalSegmentModel({
    required this.segmentId,
    required this.status,
    required this.weight,
    required this.weighedAt,
    required this.images,
    required this.items,
  });

  factory ExternalSegmentModel.fromJson(Map<String, dynamic> json) {
    return ExternalSegmentModel(
      segmentId: json['segmentId'] as String,
      status: json['status'] as String,
      weight: json['weight'] as num,
      weighedAt: DateTime.parse(json['weighedAt'] as String),
      images: List<String>.from(json['images'] ?? []),
      items: (json['items'] as List<dynamic>)
          .map(
            (e) => ExternalSegmentItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'segmentId': segmentId,
      'status': status,
      'weight': weight,
      'weighedAt': weighedAt.toIso8601String(),
      'images': images,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ExternalSegmentModel(segmentId: $segmentId, status: $status, '
        'weight: $weight, weighedAt: $weighedAt, '
        'images: $images, items: $items)';
  }

  ExternalSegmentModel copyWith({
    String? segmentId,
    String? status,
    num? weight,
    DateTime? weighedAt,
    List<String>? images,
    List<ExternalSegmentItemModel>? items,
  }) {
    return ExternalSegmentModel(
      segmentId: segmentId ?? this.segmentId,
      status: status ?? this.status,
      weight: weight ?? this.weight,
      weighedAt: weighedAt ?? this.weighedAt,
      images: images ?? this.images,
      items: items ?? this.items,
    );
  }
}
