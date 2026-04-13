class UpdateProfileModel {
  final String businessName;
  final String rawBusinessType;
  final String businessAddress;
  final String doshManagerName;
  final String doshManagerPhone;

  UpdateProfileModel({
    required this.businessName,
    required this.rawBusinessType,
    required this.businessAddress,
    required this.doshManagerName,
    required this.doshManagerPhone,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      businessName: json['bussinessName'] as String,
      rawBusinessType: json['rawBusinessType'] as String,
      businessAddress: json['bussinessAdress'] as String,
      doshManagerName: json['doshMangerName'] as String,
      doshManagerPhone: json['doshMangerPhone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bussinessName': businessName,
      'rawBusinessType': rawBusinessType,
      'bussinessAdress': businessAddress,
      'doshMangerName': doshManagerName,
      'doshMangerPhone': doshManagerPhone,
    };
  }

  @override
  String toString() {
    return 'UpdateProfileModel(businessName: $businessName, '
        'rawBusinessType: $rawBusinessType, businessAddress: $businessAddress, '
        'doshManagerName: $doshManagerName, doshManagerPhone: $doshManagerPhone)';
  }

  UpdateProfileModel copyWith({
    String? businessName,
    String? rawBusinessType,
    String? businessAddress,
    String? doshManagerName,
    String? doshManagerPhone,
  }) {
    return UpdateProfileModel(
      businessName: businessName ?? this.businessName,
      rawBusinessType: rawBusinessType ?? this.rawBusinessType,
      businessAddress: businessAddress ?? this.businessAddress,
      doshManagerName: doshManagerName ?? this.doshManagerName,
      doshManagerPhone: doshManagerPhone ?? this.doshManagerPhone,
    );
  }
}
