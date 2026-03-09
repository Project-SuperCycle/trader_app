import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';

// ─── Payment Method Types ─────────────────────────────────────────────────────

enum PaymentMethodType { cash, card, eWallet, bankTransfer }

extension PaymentMethodTypeExtension on PaymentMethodType {
  String get label {
    switch (this) {
      case PaymentMethodType.cash:         return 'كاش';
      case PaymentMethodType.card:         return 'بطاقة بنكية';
      case PaymentMethodType.eWallet:      return 'محفظة إلكترونية';
      case PaymentMethodType.bankTransfer: return 'تحويل بنكي';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentMethodType.cash:         return Icons.payments_outlined;
      case PaymentMethodType.card:         return Icons.credit_card_outlined;
      case PaymentMethodType.eWallet:      return Icons.account_balance_wallet_outlined;
      case PaymentMethodType.bankTransfer: return Icons.account_balance_outlined;
    }
  }
}

// ─── Payment Info Model ───────────────────────────────────────────────────────

class PaymentInfoModel {
  final PaymentMethodType methodType;
  final String? cardNumber;
  final String? cardHolder;
  final String? cardExpiry;
  final String? eWalletProvider;
  final String? walletPhone;
  final String? bankName;
  final String? accountHolder;
  final String? accountNumber;

  const PaymentInfoModel({
    required this.methodType,
    this.cardNumber,
    this.cardHolder,
    this.cardExpiry,
    this.eWalletProvider,
    this.walletPhone,
    this.bankName,
    this.accountHolder,
    this.accountNumber,
  });
}

// ─── بطاقة بيانات الدفع (للبروفايل الرئيسي) ─────────────────────────────────

class TraderPaymentInfoSection extends StatelessWidget {
  final PaymentInfoModel paymentInfo;

  const TraderPaymentInfoSection({super.key, required this.paymentInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('بيانات الدفع', style: AppStyles.styleSemiBold18(context)),
            const SizedBox(height: 24),
            ..._buildDetailRows(paymentInfo),
          ],
        ),
      ),
    );
  }
}

// ─── صفوف بيانات الدفع (للفروع — بدون بطاقة) ───────────────────────────────

class BranchPaymentInfoRows extends StatelessWidget {
  final PaymentInfoModel paymentInfo;

  const BranchPaymentInfoRows({super.key, required this.paymentInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // فاصل بعنوان
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('بيانات الدفع', style: AppStyles.styleSemiBold18(context)),
            ),
            Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
          ],
        ),
        const SizedBox(height: 16),
        ..._buildDetailRows(paymentInfo),
      ],
    );
  }
}

// ─── دالة مشتركة تبني الصفوف ────────────────────────────────────────────────

List<Widget> _buildDetailRows(PaymentInfoModel p) {
  final rows = <_PaymentRow>[];

  rows.add(_PaymentRow(p.methodType.icon, 'طريقة الدفع', p.methodType.label));

  switch (p.methodType) {
    case PaymentMethodType.cash:
      rows.add(const _PaymentRow(
        Icons.info_outline, 'ملاحظة', 'سيتم الدفع نقداً عند التسليم',
      ));
      break;
    case PaymentMethodType.card:
      if (p.cardNumber != null)
        rows.add(_PaymentRow(Icons.credit_card_outlined, 'رقم البطاقة', _maskCard(p.cardNumber!)));
      if (p.cardHolder != null)
        rows.add(_PaymentRow(Icons.person_outline, 'اسم حامل البطاقة', p.cardHolder!));
      if (p.cardExpiry != null)
        rows.add(_PaymentRow(Icons.calendar_today_outlined, 'تاريخ الانتهاء', p.cardExpiry!));
      break;
    case PaymentMethodType.eWallet:
      if (p.eWalletProvider != null)
        rows.add(_PaymentRow(Icons.account_balance_wallet_outlined, 'نوع المحفظة', p.eWalletProvider!));
      if (p.walletPhone != null)
        rows.add(_PaymentRow(Icons.phone_outlined, 'رقم المحفظة', p.walletPhone!));
      break;
    case PaymentMethodType.bankTransfer:
      if (p.bankName != null)
        rows.add(_PaymentRow(Icons.account_balance_outlined, 'اسم البنك', p.bankName!));
      if (p.accountHolder != null)
        rows.add(_PaymentRow(Icons.person_outline, 'اسم صاحب الحساب', p.accountHolder!));
      if (p.accountNumber != null)
        rows.add(_PaymentRow(Icons.numbers_outlined, 'رقم الحساب / IBAN', _maskAccount(p.accountNumber!)));
      break;
  }

  return rows
      .map((r) => Padding(padding: const EdgeInsets.only(bottom: 16), child: r))
      .toList();
}

String _maskCard(String raw) {
  final d = raw.replaceAll(RegExp(r'\D'), '');
  if (d.length < 4) return raw;
  return '**** **** **** ${d.substring(d.length - 4)}';
}

String _maskAccount(String raw) {
  if (raw.length <= 8) return raw;
  return '${raw.substring(0, 4)}••••••••${raw.substring(raw.length - 4)}';
}

// ─── صف واحد — نفس _DetailRow بتاع trader_main_branch_section بالظبط ─────────

class _PaymentRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _PaymentRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withAlpha(25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF10B981), size: 25),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(value, style: AppStyles.styleSemiBold14(context)),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppStyles.styleSemiBold12(context)
                    .copyWith(color: AppColors.subTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}