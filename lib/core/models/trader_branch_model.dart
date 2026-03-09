import 'package:trader_app/features/trader_main_profile/presentation/widgets/trader_payment_info_section.dart';

class TraderBranchModel {
  final String branchId;
  final String branchName;
  final String address;
  final String contactName;
  final String contactPhone;
  final int deliveryVolume;
  final List<String> recyclableTypes;
  final List<int> deliverySchedule; // تغير من String لـ List<int>
  final PaymentInfoModel? paymentInfo;

  const TraderBranchModel({
    required this.branchId,
    required this.branchName,
    required this.address,
    required this.contactName,
    required this.contactPhone,
    required this.deliveryVolume,
    required this.recyclableTypes,
    required this.deliverySchedule,
    this.paymentInfo,
  });

  factory TraderBranchModel.fromJson(Map<String, dynamic> json) {
    // استخراج shipmentDays من contractConfig
    List<int> shipmentDays = [];
    if (json['contractConfig'] != null &&
        json['contractConfig']['shipmentDays'] != null) {
      shipmentDays = List<int>.from(json['contractConfig']['shipmentDays']);
    }

    // استخراج recyclableTypes من stats
    List<String> types = [];
    if (json['stats'] != null &&
        json['stats']['doshType'] != null &&
        json['stats']['doshType']['name'] != null) {
      types = [json['stats']['doshType']['name']];
    }

    return TraderBranchModel(
      branchId: json['branchId'] ?? '',
      branchName: json['branchName'] ?? '',
      address: json['address'] ?? '',
      contactName: json['contactName'] ?? '',
      contactPhone: json['contactPhone'] ?? '',
      deliveryVolume: json['stats']?['totalDeliveredKg'] ?? 0,
      recyclableTypes: types,
      deliverySchedule: shipmentDays,
      paymentInfo: json['paymentInfo'] != null
          ? _paymentInfoFromJson(json['paymentInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'branchName': branchName,
      'address': address,
      'contactName': contactName,
      'contactPhone': contactPhone,
      'deliveryVolume': deliveryVolume,
      'recyclableTypes': recyclableTypes,
      'deliverySchedule': deliverySchedule,
      'paymentInfo': paymentInfo != null ? _paymentInfoToMap(paymentInfo!) : null,
    };
  }

  // toMap method for storage (same as toJson for this model)
  Map<String, dynamic> toMap() {
    return {
      'branchId': branchId,
      'branchName': branchName,
      'address': address,
      'contactName': contactName,
      'contactPhone': contactPhone,
      'deliveryVolume': deliveryVolume,
      'recyclableTypes': recyclableTypes,
      'deliverySchedule': deliverySchedule,
      'paymentInfo': paymentInfo != null ? _paymentInfoToMap(paymentInfo!) : null,
    };
  }

  // fromMap method for retrieving from storage
  factory TraderBranchModel.fromMap(Map<String, dynamic> map) {
    return TraderBranchModel(
      branchId: map['branchId'] ?? '',
      branchName: map['branchName'] ?? '',
      address: map['address'] ?? '',
      contactName: map['contactName'] ?? '',
      contactPhone: map['contactPhone'] ?? '',
      deliveryVolume: map['deliveryVolume'] ?? 0,
      recyclableTypes: List<String>.from(map['recyclableTypes'] ?? []),
      deliverySchedule: List<int>.from(map['deliverySchedule'] ?? []),
      paymentInfo: map['paymentInfo'] != null
          ? _paymentInfoFromJson(map['paymentInfo'])
          : null,
    );
  }

  @override
  String toString() {
    return '''
TraderBranchModel {
  Branch ID: $branchId
  Branch Name: $branchName
  Address: $address
  Contact Name: $contactName
  Contact Phone: $contactPhone
  Delivery Volume: $deliveryVolume kg
  Recyclable Types: ${recyclableTypes.join(', ')}
  Delivery Schedule (Days): $deliverySchedule
  Delivery Days: ${getDeliveryDaysText()}
}''';
  }

  TraderBranchModel copyWith({
    String? branchId,
    String? branchName,
    String? address,
    String? contactName,
    String? contactPhone,
    int? deliveryVolume,
    List<String>? recyclableTypes,
    List<int>? deliverySchedule,
    PaymentInfoModel? paymentInfo,
  }) {
    return TraderBranchModel(
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
      deliveryVolume: deliveryVolume ?? this.deliveryVolume,
      recyclableTypes: recyclableTypes ?? this.recyclableTypes,
      deliverySchedule: deliverySchedule ?? this.deliverySchedule,
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

  // Helper method لتحويل shipmentDays لأسماء الأيام
  String getDeliveryDaysText() {
    const Map<int, String> dayNames = {
      0: 'الأحد',
      1: 'الإثنين',
      2: 'الثلاثاء',
      3: 'الأربعاء',
      4: 'الخميس',
      5: 'الجمعة',
      6: 'السبت',
    };

    if (deliverySchedule.isEmpty) return 'غير محدد';

    return deliverySchedule
        .map((day) => dayNames[day] ?? '')
        .where((day) => day.isNotEmpty)
        .join(', ');
  }
}