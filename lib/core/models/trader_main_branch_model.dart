import 'package:trader_app/features/trader_main_profile/presentation/widgets/trader_payment_info_section.dart';

class TraderMainBranchModel {
  final String? branchName;
  final String? address;
  final String? contactName;
  final String? contactPhone;
  final DateTime? startDate;
  final PaymentInfoModel? paymentInfo;

  TraderMainBranchModel({
    required this.branchName,
    required this.address,
    required this.contactName,
    required this.contactPhone,
    required this.startDate,
    this.paymentInfo,
  });

  // Factory constructor for creating a new instance from a map (JSON)
  factory TraderMainBranchModel.fromJson(Map<String, dynamic> json) {
    return TraderMainBranchModel(
      branchName: json['branchName'],
      address: json['address'],
      contactName: json['contactName'],
      contactPhone: json['contactPhone'],
      startDate: DateTime.parse(json['createdAt']),
      paymentInfo: json['paymentInfo'] != null
          ? _paymentInfoFromJson(json['paymentInfo'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branchName': branchName,
      'address': address,
      'contactName': contactName,
      'contactPhone': contactPhone,
      'startDate': DateTime.parse(startDate.toString()),
      'paymentInfo': paymentInfo != null ? _paymentInfoToMap(paymentInfo!) : null,
    };
  }

  TraderMainBranchModel copyWith({
    String? branchName,
    String? address,
    String? contactName,
    String? contactPhone,
    DateTime? startDate,
    PaymentInfoModel? paymentInfo,
  }) {
    return TraderMainBranchModel(
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
      startDate: startDate ?? this.startDate,
      paymentInfo: paymentInfo ?? this.paymentInfo,
    );
  }

  // ── Payment Info Helpers ──────────────────────────────────────────────────

  static PaymentInfoModel _paymentInfoFromJson(Map<String, dynamic> json) {
    final methodType = PaymentMethodType.values.firstWhere(
          (e) => e.name == json['methodType'],
      orElse: () => PaymentMethodType.cash,
    );
    return PaymentInfoModel(
      methodType: methodType,
      cardNumber: json['cardNumber'],
      cardHolder: json['cardHolder'],
      cardExpiry: json['cardExpiry'],
      eWalletProvider: json['eWalletProvider'],
      walletPhone: json['walletPhone'],
      bankName: json['bankName'],
      accountHolder: json['accountHolder'],
      accountNumber: json['accountNumber'],
    );
  }

  static Map<String, dynamic> _paymentInfoToMap(PaymentInfoModel p) {
    return {
      'methodType': p.methodType.name,
      'cardNumber': p.cardNumber,
      'cardHolder': p.cardHolder,
      'cardExpiry': p.cardExpiry,
      'eWalletProvider': p.eWalletProvider,
      'walletPhone': p.walletPhone,
      'bankName': p.bankName,
      'accountHolder': p.accountHolder,
      'accountNumber': p.accountNumber,
    };
  }
}