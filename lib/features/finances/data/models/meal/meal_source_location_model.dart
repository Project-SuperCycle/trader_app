class MealSourceLocationModel {
  final String locationId;
  final String branchName;
  final String address;

  MealSourceLocationModel({
    required this.locationId,
    required this.branchName,
    required this.address,
  });

  factory MealSourceLocationModel.fromJson(Map<String, dynamic> json) {
    return MealSourceLocationModel(
      locationId: json['locationId'] as String,
      branchName: json['branchName'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationId': locationId,
      'branchName': branchName,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'MealSourceLocationModel(locationId: $locationId, '
        'branchName: $branchName, address: $address)';
  }

  MealSourceLocationModel copyWith({
    String? locationId,
    String? branchName,
    String? address,
  }) {
    return MealSourceLocationModel(
      locationId: locationId ?? this.locationId,
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
    );
  }
}
