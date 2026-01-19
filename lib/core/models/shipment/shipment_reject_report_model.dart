class ShipmentRejectReportModel {
  final int rank;
  final String action;
  final String reason;
  final List<String> images;

  ShipmentRejectReportModel({
    required this.rank,
    required this.action,
    required this.reason,
    required this.images,
  });

  factory ShipmentRejectReportModel.fromJson(Map<String, dynamic> json) {
    return ShipmentRejectReportModel(
      rank: json['rank'] ?? 0,
      action: json['action'] ?? "",
      reason: json['reason'] ?? "",
      images: json['images'] != null ? List<String>.from(json['images']) : [],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {'rank': rank, 'action': action, 'reason': reason, 'images': images};
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'ShipmentRejectReportModel(rank: $rank, action: $action, reason: $reason, images: ${images.length} images)';
  }

  // Optional: copyWith method for creating modified copies
  ShipmentRejectReportModel copyWith({
    int? rank,
    String? action,
    String? reason,
    List<String>? images,
  }) {
    return ShipmentRejectReportModel(
      rank: rank ?? this.rank,
      action: action ?? this.action,
      reason: reason ?? this.reason,
      images: images ?? this.images,
    );
  }

  // Optional: equality operator for comparing instances
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShipmentRejectReportModel &&
        other.rank == rank &&
        other.action == action &&
        other.reason == reason &&
        _listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return rank.hashCode ^ action.hashCode ^ reason.hashCode ^ images.hashCode;
  }

  // Helper method for list comparison
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    if (identical(a, b)) return true;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }

  // Optional: check if report has images
  bool get hasImages => images.isNotEmpty;

  // Optional: get images count
  int get imagesCount => images.length;
}
