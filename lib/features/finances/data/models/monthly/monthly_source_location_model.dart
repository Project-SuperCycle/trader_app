class MonthlySourceLocationModel {
  final String locationId;
  final String branchName;
  final String address;

  MonthlySourceLocationModel({
    required this.locationId,
    required this.branchName,
    required this.address,
  });

  factory MonthlySourceLocationModel.fromJson(Map<String, dynamic> json) {
    return MonthlySourceLocationModel(
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
    return 'MonthlySourceLocationModel(locationId: $locationId, '
        'branchName: $branchName, address: $address)';
  }

  MonthlySourceLocationModel copyWith({
    String? locationId,
    String? branchName,
    String? address,
  }) {
    return MonthlySourceLocationModel(
      locationId: locationId ?? this.locationId,
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
    );
  }
}
