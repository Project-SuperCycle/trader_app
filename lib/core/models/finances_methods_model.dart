import 'package:trader_app/features/finances/data/models/methods/bank_transfer_method_model.dart';
import 'package:trader_app/features/finances/data/models/methods/wallet_method_model.dart';

class FinancesMethodsModel {
  final bool cash;
  final BankTransferMethodModel bankTransfer;
  final WalletMethodModel wallet;

  FinancesMethodsModel({
    required this.cash,
    required this.bankTransfer,
    required this.wallet,
  });

  factory FinancesMethodsModel.fromJson(Map<String, dynamic> json) {
    return FinancesMethodsModel(
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
    return 'UpdateFinanceMethodsModel(cash: $cash, '
        'bankTransfer: $bankTransfer, wallet: $wallet)';
  }

  FinancesMethodsModel copyWith({
    bool? cash,
    BankTransferMethodModel? bankTransfer,
    WalletMethodModel? wallet,
  }) {
    return FinancesMethodsModel(
      cash: cash ?? this.cash,
      bankTransfer: bankTransfer ?? this.bankTransfer,
      wallet: wallet ?? this.wallet,
    );
  }
}
