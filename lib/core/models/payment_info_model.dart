// lib/features/sign_up/data/models/payment_info_model.dart

enum PaymentMethodType { cash, card, eWallet, bankTransfer }

extension PaymentMethodTypeX on PaymentMethodType {
  String get value {
    switch (this) {
      case PaymentMethodType.cash:         return 'cash';
      case PaymentMethodType.card:         return 'card';
      case PaymentMethodType.eWallet:      return 'e_wallet';
      case PaymentMethodType.bankTransfer: return 'bank_transfer';
    }
  }

  String get label {
    switch (this) {
      case PaymentMethodType.cash:         return 'كاش';
      case PaymentMethodType.card:         return 'بطاقة بنكية';
      case PaymentMethodType.eWallet:      return 'محفظة إلكترونية';
      case PaymentMethodType.bankTransfer: return 'تحويل بنكي';
    }
  }

  static PaymentMethodType fromValue(String value) {
    switch (value) {
      case 'card':          return PaymentMethodType.card;
      case 'e_wallet':      return PaymentMethodType.eWallet;
      case 'bank_transfer': return PaymentMethodType.bankTransfer;
      default:              return PaymentMethodType.cash;
    }
  }
}

class PaymentInfoModel {
  final PaymentMethodType method;

  // بطاقة بنكية
  final String? cardNumber;
  final String? cardHolder;
  final String? cardExpiry;

  // محفظة إلكترونية
  final String? eWalletProvider;
  final String? eWalletPhone;

  // تحويل بنكي
  final String? bankName;
  final String? accountHolder;
  final String? accountNumber;

  const PaymentInfoModel({
    required this.method,
    this.cardNumber,
    this.cardHolder,
    this.cardExpiry,
    this.eWalletProvider,
    this.eWalletPhone,
    this.bankName,
    this.accountHolder,
    this.accountNumber,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) {
    return PaymentInfoModel(
      method:          PaymentMethodTypeX.fromValue(json['method'] as String? ?? 'cash'),
      cardNumber:      json['cardNumber']      as String?,
      cardHolder:      json['cardHolder']      as String?,
      cardExpiry:      json['cardExpiry']      as String?,
      eWalletProvider: json['eWalletProvider'] as String?,
      eWalletPhone:    json['eWalletPhone']    as String?,
      bankName:        json['bankName']        as String?,
      accountHolder:   json['accountHolder']  as String?,
      accountNumber:   json['accountNumber']  as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'method': method.value,
    if (cardNumber      != null) 'cardNumber':      cardNumber,
    if (cardHolder      != null) 'cardHolder':      cardHolder,
    if (cardExpiry      != null) 'cardExpiry':      cardExpiry,
    if (eWalletProvider != null) 'eWalletProvider': eWalletProvider,
    if (eWalletPhone    != null) 'eWalletPhone':    eWalletPhone,
    if (bankName        != null) 'bankName':        bankName,
    if (accountHolder   != null) 'accountHolder':   accountHolder,
    if (accountNumber   != null) 'accountNumber':   accountNumber,
  };

  /// ملخص للعرض في البروفايل — مثال: "بطاقة بنكية — **** 4242"
  String get displaySummary {
    switch (method) {
      case PaymentMethodType.cash:
        return 'كاش — الدفع عند الاستلام';
      case PaymentMethodType.card:
        final last4 = (cardNumber ?? '').replaceAll(' ', '');
        final suffix = last4.length >= 4
            ? '**** ${last4.substring(last4.length - 4)}'
            : '';
        return 'بطاقة بنكية${suffix.isNotEmpty ? ' — $suffix' : ''}';
      case PaymentMethodType.eWallet:
        return 'محفظة إلكترونية — ${eWalletProvider ?? ''} ${eWalletPhone ?? ''}'.trim();
      case PaymentMethodType.bankTransfer:
        return 'تحويل بنكي — ${bankName ?? ''}';
    }
  }

  PaymentInfoModel copyWith({
    PaymentMethodType? method,
    String? cardNumber,
    String? cardHolder,
    String? cardExpiry,
    String? eWalletProvider,
    String? eWalletPhone,
    String? bankName,
    String? accountHolder,
    String? accountNumber,
  }) =>
      PaymentInfoModel(
        method:          method          ?? this.method,
        cardNumber:      cardNumber      ?? this.cardNumber,
        cardHolder:      cardHolder      ?? this.cardHolder,
        cardExpiry:      cardExpiry      ?? this.cardExpiry,
        eWalletProvider: eWalletProvider ?? this.eWalletProvider,
        eWalletPhone:    eWalletPhone    ?? this.eWalletPhone,
        bankName:        bankName        ?? this.bankName,
        accountHolder:   accountHolder  ?? this.accountHolder,
        accountNumber:   accountNumber  ?? this.accountNumber,
      );
}