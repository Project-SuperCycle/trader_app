import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/utils/input_decorations.dart';

// ─── تفاصيل الدفع: تحويل بنكي ────────────────────────────────────────────────

class BankTransferDetails extends StatelessWidget {
  final TextEditingController bankNameController;
  final TextEditingController accountHolderController;
  final TextEditingController accountNumberController;

  final TextEditingController accountIbanController;

  const BankTransferDetails({
    super.key,
    required this.bankNameController,
    required this.accountHolderController,
    required this.accountNumberController,
    required this.accountIbanController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TextFormField(
          controller: bankNameController,
          style: AppStyles.styleRegular14(context),
          decoration: InputDecoration(
            labelText: 'اسم البنك',
            hintText: 'مثال: البنك الأهلي المصري',
            labelStyle: AppStyles.styleRegular14(
              context,
            ).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: accountHolderController,
          keyboardType: TextInputType.name,
          style: AppStyles.styleRegular14(context),
          decoration: InputDecoration(
            labelText: 'اسم صاحب الحساب',
            hintText: 'الاسم الكامل كما في البنك',
            labelStyle: AppStyles.styleRegular14(
              context,
            ).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: accountNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: AppStyles.styleRegular14(context),
          decoration: InputDecoration(
            labelText: 'رقم الحساب',
            hintText: 'أدخل رقم الحساب البنكي',
            labelStyle: AppStyles.styleRegular14(
              context,
            ).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: accountIbanController,
          keyboardType: TextInputType.text,
          style: AppStyles.styleRegular14(context),
          decoration: InputDecoration(
            labelText: 'IBAN',
            hintText: 'أدخل رقم الحساب المصرفي',
            labelStyle: AppStyles.styleRegular14(
              context,
            ).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
