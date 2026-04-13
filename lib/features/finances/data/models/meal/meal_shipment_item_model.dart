class MealShipmentItemModel {
  final String doshType; // NOTE: id only, no doshTypeName in meal response
  final num quantityKg;
  final num pricePerKg;

  MealShipmentItemModel({
    required this.doshType,
    required this.quantityKg,
    required this.pricePerKg,
  });

  factory MealShipmentItemModel.fromJson(Map<String, dynamic> json) {
    return MealShipmentItemModel(
      doshType: json['doshType'] as String,
      quantityKg: json['quantityKg'] as num,
      pricePerKg: json['pricePerKg'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doshType': doshType,
      'quantityKg': quantityKg,
      'pricePerKg': pricePerKg,
    };
  }

  @override
  String toString() {
    return 'MealShipmentItemModel(doshType: $doshType, '
        'quantityKg: $quantityKg, pricePerKg: $pricePerKg)';
  }

  MealShipmentItemModel copyWith({
    String? doshType,
    num? quantityKg,
    num? pricePerKg,
  }) {
    return MealShipmentItemModel(
      doshType: doshType ?? this.doshType,
      quantityKg: quantityKg ?? this.quantityKg,
      pricePerKg: pricePerKg ?? this.pricePerKg,
    );
  }
}
