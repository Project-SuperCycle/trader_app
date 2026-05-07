import 'package:flutter/material.dart';
import 'package:trader_app/core/models/finances_methods_model.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/finances_part/info_row.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/finances_part/payment_method_card.dart';

class FinancesMethodsCards extends StatefulWidget {
  const FinancesMethodsCards({super.key});

  @override
  State<FinancesMethodsCards> createState() => _FinancesMethodsCardsState();
}

class _FinancesMethodsCardsState extends State<FinancesMethodsCards> {
  FinancesMethodsModel? methods;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMethods();
  }

  Future<void> _loadMethods() async {
    final result = await StorageServices.getFinancesMethods();
    if (!mounted) return;
    setState(() {
      methods = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();
    if (methods == null) return const SizedBox.shrink();

    final bank = methods!.bankTransfer;
    final wallet = methods!.wallet;

    final List<Widget> enabledCards = [];

    if (methods!.cash) {
      enabledCards.add(
        PaymentMethodCard(
          icon: Icons.payments_outlined,
          title: 'كاش',
          subtitle: 'طريقة الدفع',
        ),
      );
    }

    if (bank.enabled) {
      enabledCards.add(
        PaymentMethodCard(
          icon: Icons.credit_card_outlined,
          title: 'تحويل بنكي',
          subtitle: 'طريقة الدفع',
          rows: [
            if (bank.bankName != null) InfoRow('البنك', bank.bankName!),
            if (bank.accountNumber != null)
              InfoRow('رقم الحساب', bank.accountNumber!),
            if (bank.iban != null) InfoRow('IBAN', bank.iban!),
          ],
        ),
      );
    }

    if (wallet.enabled) {
      enabledCards.add(
        PaymentMethodCard(
          icon: Icons.account_balance_wallet_outlined,
          title: 'المحفظة الإلكترونية',
          subtitle: 'طريقة الدفع',
          rows: [
            if (wallet.walletNumber != null)
              InfoRow('رقم المحفظة', wallet.walletNumber!),
          ],
        ),
      );
    }

    if (enabledCards.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (int i = 0; i < enabledCards.length; i++) ...[
          enabledCards[i],
          if (i != enabledCards.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}
