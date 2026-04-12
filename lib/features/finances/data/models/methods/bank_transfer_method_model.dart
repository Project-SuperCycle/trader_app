class BankTransferMethodModel {
  final bool enabled;
  final String? bankName;
  final String? accountNumber;
  final String? iban;

  BankTransferMethodModel({
    required this.enabled,
    this.bankName,
    this.accountNumber,
    this.iban,
  });

  factory BankTransferMethodModel.fromJson(Map<String, dynamic> json) {
    return BankTransferMethodModel(
      enabled: json['enabled'] as bool,
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      iban: json['iban'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'iban': iban,
    };
  }

  @override
  String toString() {
    return 'BankTransferMethodModel(enabled: $enabled, bankName: $bankName, '
        'accountNumber: $accountNumber, iban: $iban)';
  }

  BankTransferMethodModel copyWith({
    bool? enabled,
    String? bankName,
    String? accountNumber,
    String? iban,
  }) {
    return BankTransferMethodModel(
      enabled: enabled ?? this.enabled,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      iban: iban ?? this.iban,
    );
  }
}
