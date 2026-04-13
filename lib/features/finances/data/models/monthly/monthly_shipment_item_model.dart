class MonthlyShipmentItemModel {
  final String doshTypeId;
  final String doshTypeName;
  final String unit;
  final num quantityKg;
  final num? pricePerKg; // present in parent items, absent in segment items

  MonthlyShipmentItemModel({
    required this.doshTypeId,
    required this.doshTypeName,
    required this.unit,
    required this.quantityKg,
    this.pricePerKg,
  });

  factory MonthlyShipmentItemModel.fromJson(Map<String, dynamic> json) {
    return MonthlyShipmentItemModel(
      doshTypeId: json['doshTypeId'] as String,
      doshTypeName: json['doshTypeName'] as String,
      unit: json['unit'] as String,
      quantityKg: json['quantityKg'] as num,
      pricePerKg: json['pricePerKg'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doshTypeId': doshTypeId,
      'doshTypeName': doshTypeName,
      'unit': unit,
      'quantityKg': quantityKg,
      if (pricePerKg != null) 'pricePerKg': pricePerKg,
    };
  }

  @override
  String toString() {
    return 'MonthlyShipmentItemModel(doshTypeId: $doshTypeId, '
        'doshTypeName: $doshTypeName, unit: $unit, '
        'quantityKg: $quantityKg, pricePerKg: $pricePerKg)';
  }

  MonthlyShipmentItemModel copyWith({
    String? doshTypeId,
    String? doshTypeName,
    String? unit,
    num? quantityKg,
    num? pricePerKg,
  }) {
    return MonthlyShipmentItemModel(
      doshTypeId: doshTypeId ?? this.doshTypeId,
      doshTypeName: doshTypeName ?? this.doshTypeName,
      unit: unit ?? this.unit,
      quantityKg: quantityKg ?? this.quantityKg,
      pricePerKg: pricePerKg ?? this.pricePerKg,
    );
  }
}
