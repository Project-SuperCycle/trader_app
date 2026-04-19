// ─── Widget: قسم طريقة الدفع ─────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/helpers/custom_dropdown.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/models/finances_methods_model.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/widgets/custom_button.dart';
import 'package:trader_app/features/finances/data/models/methods/bank_transfer_method_model.dart';
import 'package:trader_app/features/finances/data/models/methods/wallet_method_model.dart';
import 'package:trader_app/features/sign_up/data/classes/payment_method_option.dart';
import 'package:trader_app/features/sign_up/data/managers/sign_up_cubit/sign_up_cubit.dart';
import 'package:trader_app/features/sign_up/data/models/business_information_model.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/finances/bank_transfer_details.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/finances/cash_details.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/finances/e_wallet_details.dart';

class PaymentMethodSection extends StatefulWidget {
  final List<PaymentMethodOption> paymentOptions;
  final Map<String, TextEditingController> controllers;

  final BusinessInformationModel businessInfo;

  const PaymentMethodSection({
    super.key,
    required this.paymentOptions,
    required this.controllers,
    required this.businessInfo,
  });

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  final List<Map<String, dynamic>> _selectedMethods = [];
  String? _pendingLabel; // ✅ هنا بدل جوه _buildAddMethodRow

  List<PaymentMethodOption> get _availableOptions {
    final selectedTypes = _selectedMethods
        .map((e) => e['type'] as PaymentMethodType)
        .toSet();
    return widget.paymentOptions
        .where((o) => !selectedTypes.contains(o.type))
        .toList();
  }

  void _addMethod(String? label) {
    if (label == null) return;
    final option = widget.paymentOptions.firstWhere((o) => o.label == label);
    setState(() {
      _selectedMethods.add({'type': option.type, 'eWalletProvider': null});
      _pendingLabel = null; // ✅ reset بعد الإضافة
    });
  }

  void _removeMethod(int index) {
    setState(() => _selectedMethods.removeAt(index));
  }

  void _updateEWalletProvider(int index, String? provider) {
    setState(() => _selectedMethods[index]['eWalletProvider'] = provider);
  }

  void _handleSubmit() {
    // needed data
    bool cash = false;
    bool eWallet = false;
    bool bankTransfer = false;

    String bankName = '';
    String accountNumber = '';
    String accountIbn = '';

    String walletPhone = '';

    // collect data from controllers
    for (final method in _selectedMethods) {
      if (method['type'] == PaymentMethodType.cash) {
        cash = true;
        continue;
      }

      if (method['type'] == PaymentMethodType.eWallet) {
        eWallet = true;
        walletPhone = widget.controllers['walletPhone']!.text.trim();
        continue;
      }

      if (method['type'] == PaymentMethodType.bankTransfer) {
        bankTransfer = true;
        bankName = widget.controllers['bankName']!.text.trim();
        accountNumber = widget.controllers['accountNumber']!.text.trim();
        accountIbn = widget.controllers['accountHolder']!.text.trim();
        continue;
      }
    }

    FinancesMethodsModel methodsModel = FinancesMethodsModel(
      cash: cash,
      bankTransfer: BankTransferMethodModel(
        enabled: bankTransfer,
        bankName: bankName,
        accountNumber: accountNumber,
        iban: accountIbn,
      ),
      wallet: WalletMethodModel(enabled: eWallet, walletNumber: walletPhone),
    );
    BlocProvider.of<SignUpCubit>(
      context,
    ).completeSignup(businessInfo: widget.businessInfo, methods: methodsModel);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._selectedMethods.asMap().entries.map((entry) {
          final index = entry.key;
          final method = entry.value;
          final type = method['type'] as PaymentMethodType;
          final option = widget.paymentOptions.firstWhere(
            (o) => o.type == type,
          );

          return Column(
            key: ValueKey(type),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(option.icon, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    option.label,
                    style: AppStyles.styleSemiBold20(
                      context,
                    ).copyWith(fontSize: 15),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _removeMethod(index),
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => SizeTransition(
                  sizeFactor: animation,
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: _buildPaymentDetails(type, index),
              ),
              const SizedBox(height: 12),
            ],
          );
        }),

        if (_availableOptions.isNotEmpty) _buildAddMethodRow(context),

        const SizedBox(height: 20),
        BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is CompleteSignUpSuccess) {
              GoRouter.of(context).go(EndPoints.signInView);
            }
            if (state is CompleteSignUpFailure) {
              CustomSnackBar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is CompleteSignUpLoading) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CustomLoadingIndicator(color: AppColors.primary),
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPress: () => _handleSubmit(),
                  title: 'إنشاء الحساب',
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddMethodRow(BuildContext context) {
    // ✅ تحقق إن _pendingLabel لسه موجود في الـ options المتاحة
    // لو اتشال (بعد إضافة طريقة) نعمله reset
    final validPending = _availableOptions.any((o) => o.label == _pendingLabel)
        ? _pendingLabel
        : null;

    if (validPending != _pendingLabel) {
      // schedule reset بعد الـ build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _pendingLabel = null);
      });
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomDropdown(
            options: _availableOptions.map((o) => o.label).toList(),
            hintText: 'اختر طريقة دفع',
            initialValue: validPending, // ✅ استخدام القيمة المتحقق منها
            onChanged: (value) => setState(() => _pendingLabel = value),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => _addMethod(_pendingLabel),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _pendingLabel != null
                  ? AppColors.primary
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.add,
              color: _pendingLabel != null ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails(PaymentMethodType type, int index) {
    switch (type) {
      case PaymentMethodType.cash:
        return CashDetails(key: const ValueKey('cash'));

      case PaymentMethodType.eWallet:
        return EWalletDetails(
          key: const ValueKey('ewallet'),
          providers: const ['فودافون كاش', 'فوري', 'أورنج كاش', 'إتصالات كاش'],
          selectedProvider:
              _selectedMethods[index]['eWalletProvider'] as String?,
          onProviderChanged: (p) => _updateEWalletProvider(index, p),
          phoneController: widget.controllers['walletPhone']!,
        );

      case PaymentMethodType.bankTransfer:
        return BankTransferDetails(
          key: const ValueKey('bank'),
          bankNameController: widget.controllers['bankName']!,
          accountHolderController: widget.controllers['accountHolder']!,
          accountNumberController: widget.controllers['accountNumber']!,
          accountIbanController: widget.controllers['accountIban']!,
        );
    }
  }
}
