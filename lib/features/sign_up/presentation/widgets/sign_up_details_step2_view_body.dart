import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/widgets/auth/auth_main_layout.dart';
import 'package:trader_app/core/widgets/rounded_container.dart';
import 'package:trader_app/features/sign_up/data/classes/payment_method_option.dart';
import 'package:trader_app/features/sign_up/data/models/business_information_model.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/finances/payment_method_section.dart';

class SignUpDetailsStep2ViewBody extends StatefulWidget {
  final BusinessInformationModel businessInfo;

  const SignUpDetailsStep2ViewBody({super.key, required this.businessInfo});

  @override
  State<SignUpDetailsStep2ViewBody> createState() =>
      _SignUpDetailsStep2ViewBodyState();
}

class _SignUpDetailsStep2ViewBodyState
    extends State<SignUpDetailsStep2ViewBody> {
  // ── Payment State ──────────────────────────────────────────────
  PaymentMethodType? selectedPaymentMethod;
  String? selectedEWalletProvider;

  final _controllers = {
    'walletPhone': TextEditingController(),
    'bankName': TextEditingController(),
    'accountHolder': TextEditingController(),
    'accountNumber': TextEditingController(),
    'accountIban': TextEditingController(),
  };

  static const List<PaymentMethodOption> _paymentOptions = [
    PaymentMethodOption(
      type: PaymentMethodType.cash,
      label: 'كاش',
      subtitle: 'الدفع نقداً عند التسليم',
      icon: Icons.payments_outlined,
    ),
    PaymentMethodOption(
      type: PaymentMethodType.eWallet,
      label: 'محفظة إلكترونية',
      subtitle: 'فودافون كاش / فوري / أورنج / إتصالات',
      icon: Icons.account_balance_wallet_outlined,
    ),
    PaymentMethodOption(
      type: PaymentMethodType.bankTransfer,
      label: 'تحويل بنكي',
      subtitle: 'تحويل مباشر لحساب بنكي',
      icon: Icons.account_balance_outlined,
    ),
  ];

  @override
  void dispose() {
    _controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthMainLayout(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.20),
          Expanded(
            child: RoundedContainer(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'طرق التحصيل',
                      style: AppStyles.styleSemiBold20(context),
                    ),
                  ),
                  const SizedBox(height: 30),
                  PaymentMethodSection(
                    paymentOptions: _paymentOptions,
                    controllers: _controllers,
                    businessInfo: widget.businessInfo,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
