class ExternalItemModel {
  final String doshTypeId;
  final String doshTypeName;
  final String unit;
  final num quantityKg;

  ExternalItemModel({
    required this.doshTypeId,
    required this.doshTypeName,
    required this.unit,
    required this.quantityKg,
  });

  factory ExternalItemModel.fromJson(Map<String, dynamic> json) {
    return ExternalItemModel(
      doshTypeId: json['doshTypeId'] as String,
      doshTypeName: json['doshTypeName'] as String,
      unit: json['unit'] as String,
      quantityKg: json['quantityKg'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doshTypeId': doshTypeId,
      'doshTypeName': doshTypeName,
      'unit': unit,
      'quantityKg': quantityKg,
    };
  }

  @override
  String toString() {
    return 'ExternalSegmentItemModel(doshTypeId: $doshTypeId, doshTypeName: $doshTypeName, '
        'unit: $unit, quantityKg: $quantityKg)';
  }

  ExternalItemModel copyWith({
    String? doshTypeId,
    String? doshTypeName,
    String? unit,
    num? quantityKg,
  }) {
    return ExternalItemModel(
      doshTypeId: doshTypeId ?? this.doshTypeId,
      doshTypeName: doshTypeName ?? this.doshTypeName,
      unit: unit ?? this.unit,
      quantityKg: quantityKg ?? this.quantityKg,
    );
  }
}
