import 'package:flutter/material.dart';
import 'package:trader_app/core/helpers/custom_dropdown.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/settings/data/classes/finances_methods_data.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_finances/app_text_field.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_finances/field_label.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_finances/section_card.dart';

// ─────────────────────────────────────────────
//  Widget
// ─────────────────────────────────────────────

class UpdateFinancesMethods extends StatefulWidget {
  final FinancesMethodsData? initialData;

  const UpdateFinancesMethods({super.key, this.initialData});

  @override
  State<UpdateFinancesMethods> createState() => _UpdateFinancesMethodsState();
}

class _UpdateFinancesMethodsState extends State<UpdateFinancesMethods> {
  // ── State ──
  late bool _cashEnabled;
  late bool _bankEnabled;
  late bool _walletEnabled;

  // ── Controllers ──
  late final TextEditingController _bankNameCtrl;
  late final TextEditingController _accountCtrl;
  late final TextEditingController _ibanCtrl;
  late final TextEditingController _walletCtrl;

  static const List<String> _bankOptions = [
    'البنك الأهلي',
    'بنك مصر',
    'بنك CIB',
    'بنك QNB',
    'بنك البركة',
    'بنك اسكندرية',
  ];

  String? _selectedBank;

  @override
  void initState() {
    super.initState();
    final d = widget.initialData ?? FinancesMethodsData();
    _cashEnabled = d.cashEnabled;
    _bankEnabled = d.bankEnabled;
    _walletEnabled = d.walletEnabled;
    _selectedBank = d.bankName;

    _bankNameCtrl = TextEditingController(text: d.bankName ?? '');
    _accountCtrl = TextEditingController(text: d.accountNumber ?? '');
    _ibanCtrl = TextEditingController(text: d.iban ?? '');
    _walletCtrl = TextEditingController(text: d.walletNumber ?? '');
  }

  @override
  void dispose() {
    _bankNameCtrl.dispose();
    _accountCtrl.dispose();
    _ibanCtrl.dispose();
    _walletCtrl.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────
  //  Helpers
  // ─────────────────────────────────────────

  void _save() {
    // widget.onSave?.call(
    //   FinancesMethodsData(
    //     cashEnabled: _cashEnabled,
    //     bankEnabled: _bankEnabled,
    //     bankName: _bankEnabled ? _selectedBank : null,
    //     accountNumber: _bankEnabled ? _accountCtrl.text : null,
    //     iban: _bankEnabled ? _ibanCtrl.text : null,
    //     walletEnabled: _walletEnabled,
    //     walletNumber: _walletEnabled ? _walletCtrl.text : null,
    //   ),
    // );
  }

  void _cancel() {}

  // ─────────────────────────────────────────
  //  Build
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Cash ──────────────────────────
        SectionCard(
          title: 'تحصيل النقدي',
          icon: Icons.payments_outlined,
          enabled: _cashEnabled,
          onChanged: (v) => setState(() => _cashEnabled = v),
          children: const [], // No extra fields for cash
        ),

        const SizedBox(height: 12),

        // ── Bank ──────────────────────────
        SectionCard(
          title: 'تحويل بنكي',
          icon: Icons.account_balance_outlined,
          enabled: _bankEnabled,
          onChanged: (v) => setState(() => _bankEnabled = v),
          children: [
            FieldLabel(label: 'اسم البنك'),
            CustomDropdown(
              initialValue: _selectedBank,
              hintText: 'اختر',
              options: _bankOptions,
              onChanged: (v) => setState(() => _selectedBank = v),
            ),

            const SizedBox(height: 12),
            FieldLabel(label: 'رقم الحساب'),
            AppTextField(
              controller: _accountCtrl,
              hint: '1234567890',
              inputDirection: TextDirection.ltr,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _IbanLabel(),
            AppTextField(
              controller: _ibanCtrl,
              hint: 'SA 00 0000 0000 0000 0000 0000',
              inputDirection: TextDirection.ltr,
              keyboardType: TextInputType.text,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // ── Wallet ────────────────────────
        SectionCard(
          title: 'تحويل محفظة',
          icon: Icons.account_balance_wallet_outlined,
          enabled: _walletEnabled,
          onChanged: (v) => setState(() => _walletEnabled = v),
          children: [
            FieldLabel(label: 'رقم المحفظة'),
            AppTextField(
              controller: _walletCtrl,
              hint: '05XXXXXXXX',
              inputDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),

        const SizedBox(height: 24),

        // ── Actions ───────────────────────
        SaveButton(onSave: _save),
        const SizedBox(height: 10),
        CancelButton(onCancel: _cancel),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  IBAN Label (with dots)
// ─────────────────────────────────────────────

class _IbanLabel extends StatelessWidget {
  const _IbanLabel();

  static const Color _green = Color(0xFF1B7A4A);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'IBAN',
            style: AppStyles.styleSemiBold12(
              context,
            ).copyWith(color: AppColors.subTextColor),
          ),
          const SizedBox(width: 6),
          Row(
            children: List.generate(
              3,
              (_) => Container(
                margin: const EdgeInsets.only(right: 3),
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: _green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
