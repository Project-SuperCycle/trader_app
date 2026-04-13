import 'bank_transfer_method_model.dart';
import 'wallet_method_model.dart';

class ReceivingMethodsModel {
  final bool cash;
  final BankTransferMethodModel bankTransfer;
  final WalletMethodModel wallet;

  ReceivingMethodsModel({
    required this.cash,
    required this.bankTransfer,
    required this.wallet,
  });

  factory ReceivingMethodsModel.fromJson(Map<String, dynamic> json) {
    return ReceivingMethodsModel(
      cash: json['cash'] as bool,
      bankTransfer: BankTransferMethodModel.fromJson(
        json['bankTransfer'] as Map<String, dynamic>,
      ),
      wallet: WalletMethodModel.fromJson(
        json['wallet'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cash': cash,
      'bankTransfer': bankTransfer.toJson(),
      'wallet': wallet.toJson(),
    };
  }

  @override
  String toString() {
    return 'ReceivingMethodsModel(cash: $cash, '
        'bankTransfer: $bankTransfer, wallet: $wallet)';
  }

  ReceivingMethodsModel copyWith({
    bool? cash,
    BankTransferMethodModel? bankTransfer,
    WalletMethodModel? wallet,
  }) {
    return ReceivingMethodsModel(
      cash: cash ?? this.cash,
      bankTransfer: bankTransfer ?? this.bankTransfer,
      wallet: wallet ?? this.wallet,
    );
  }
}
