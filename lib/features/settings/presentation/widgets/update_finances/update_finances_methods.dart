import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/helpers/custom_dropdown.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/models/finances_methods_model.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/models/methods/bank_transfer_method_model.dart';
import 'package:trader_app/features/finances/data/models/methods/wallet_method_model.dart';
import 'package:trader_app/features/settings/data/cubits/update_finances/update_finances_cubit.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_finances/app_text_field.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_finances/field_label.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_finances/section_card.dart';

class UpdateFinancesMethods extends StatefulWidget {
  const UpdateFinancesMethods({super.key});

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

  void _loadFinancesMethods() async {
    FinancesMethodsModel? methods = await StorageServices.getFinancesMethods();
    if (methods == null) {
      return;
    }

    setState(() {
      _cashEnabled = methods.cash;
      _bankEnabled = methods.bankTransfer.enabled;
      _walletEnabled = methods.wallet.enabled;
      _selectedBank = methods.bankTransfer.bankName;

      _bankNameCtrl = TextEditingController(
        text: methods.bankTransfer.bankName ?? '',
      );
      _accountCtrl = TextEditingController(
        text: methods.bankTransfer.accountNumber ?? '',
      );
      _ibanCtrl = TextEditingController(text: methods.bankTransfer.iban ?? '');
      _walletCtrl = TextEditingController(
        text: methods.wallet.walletNumber ?? '',
      );
    });
  }

  static const List<String> _bankOptions = [
    "البنك الأهلي المصري",
    "بنك مصر",
    "بنك القاهرة",
    "بنك الإسكندرية",
    "البنك الزراعي المصري",
    "بنك التعمير والإسكان",
    "البنك التجاري الدولي (CIB)",
    "بنك قناة السويس",
    "البنك المصري لتنمية الصادرات",
    "البنك المصري الخليجي",
    "المصرف المتحد",
    "بنك التنمية الصناعية",
    "QNB الأهلي",
    "بنك الإمارات دبي الوطني",
    "بنك أبوظبي الإسلامي",
    "بنك أبوظبي التجاري",
    "بنك الكويت الوطني",
    "البنك الأهلي الكويتي - مصر",
    "بنك فيصل الإسلامي",
    "بنك البركة",
    "البنك العربي الإفريقي الدولي",
    "البنك العربي",
    "بنك الاستثمار العربي",
    "بنك المؤسسة العربية المصرفية",
    "كريدي أجريكول مصر",
    "سيتي بنك",
    "بنك المشرق",
    "HSBC مصر",
    "بنك ناصر الاجتماعي",
    "بنك الاستثمار القومي",
  ];

  String? _selectedBank;

  @override
  void initState() {
    super.initState();
    _loadFinancesMethods();
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
    FinancesMethodsModel model = FinancesMethodsModel(
      cash: _cashEnabled,
      bankTransfer: BankTransferMethodModel(
        enabled: _bankEnabled,
        bankName: _bankEnabled ? _selectedBank : null,
        accountNumber: _bankEnabled ? _accountCtrl.text : null,
        iban: _bankEnabled ? _ibanCtrl.text : null,
      ),
      wallet: WalletMethodModel(
        enabled: _walletEnabled,
        walletNumber: _walletEnabled ? _walletCtrl.text : null,
      ),
    );
    BlocProvider.of<UpdateFinancesCubit>(
      context,
    ).updateFinancesMethods(methods: model);
  }

  void _cancel() {
    GoRouter.of(context).pop();
  }

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
              isSearchable: true,
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
        BlocConsumer<UpdateFinancesCubit, UpdateFinancesState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is UpdateFinancesSuccess) {
              GoRouter.of(context).pop();
            }
            if (state is UpdateFinancesFailure) {
              CustomSnackBar.showError(context, state.errMessage);
            }
          },
          builder: (context, state) {
            if (state is UpdateFinancesLoading) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CustomLoadingIndicator(color: AppColors.primary),
                ),
              );
            }
            return SaveButton(onSave: _save);
          },
        ),
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
