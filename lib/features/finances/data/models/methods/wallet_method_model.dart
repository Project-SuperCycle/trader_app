class WalletMethodModel {
  final bool enabled;
  final String? walletNumber;

  WalletMethodModel({required this.enabled, this.walletNumber});

  factory WalletMethodModel.fromJson(Map<String, dynamic> json) {
    return WalletMethodModel(
      enabled: json['enabled'] as bool,
      walletNumber: json['walletNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'enabled': enabled, 'walletNumber': walletNumber};
  }

  @override
  String toString() {
    return 'WalletMethodModel(enabled: $enabled, walletNumber: $walletNumber)';
  }

  WalletMethodModel copyWith({bool? enabled, String? walletNumber}) {
    return WalletMethodModel(
      enabled: enabled ?? this.enabled,
      walletNumber: walletNumber ?? this.walletNumber,
    );
  }
}
