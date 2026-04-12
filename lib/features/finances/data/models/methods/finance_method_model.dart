import 'receiving_methods_model.dart';

class FinanceMethodModel {
  final String settlementType;
  final String? paymentMethod;
  final ReceivingMethodsModel receivingMethods;

  FinanceMethodModel({
    required this.settlementType,
    required this.receivingMethods,
    this.paymentMethod,
  });

  factory FinanceMethodModel.fromJson(Map<String, dynamic> json) {
    return FinanceMethodModel(
      settlementType: json['settlementType'] as String,
      paymentMethod: json['paymentMethod'] as String?,
      receivingMethods: ReceivingMethodsModel.fromJson(
        json['receivingMethods'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'settlementType': settlementType,
      'paymentMethod': paymentMethod,
      'receivingMethods': receivingMethods.toJson(),
    };
  }

  @override
  String toString() {
    return 'FinanceMethodModel(settlementType: $settlementType, '
        'paymentMethod: $paymentMethod, receivingMethods: $receivingMethods)';
  }

  FinanceMethodModel copyWith({
    String? settlementType,
    String? paymentMethod,
    ReceivingMethodsModel? receivingMethods,
  }) {
    return FinanceMethodModel(
      settlementType: settlementType ?? this.settlementType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      receivingMethods: receivingMethods ?? this.receivingMethods,
    );
  }

  // Helper getters
  bool get hasCash => receivingMethods.cash;

  bool get hasBankTransfer => receivingMethods.bankTransfer.enabled;

  bool get hasWallet => receivingMethods.wallet.enabled;

  bool get hasSelectedMethod => paymentMethod != null;
}
