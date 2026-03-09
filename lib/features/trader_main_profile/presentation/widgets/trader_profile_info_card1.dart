import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/core/models/user_profile_model.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/utils/input_decorations.dart';
import 'package:trader_app/features/trader_main_profile/data/cubits/trader_profile_cubit.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/trader_branches_section.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/trader_main_branch_section.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/trader_payment_info_section.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/trader_profile_info_row.dart';

class TraderProfileInfoCard1 extends StatelessWidget {
  final UserProfileModel userProfile;

  const TraderProfileInfoCard1({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── البطاقة الأولى: بيانات النشاط ──────────────────────────
        Container(
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ..._buildProfileInfoRows(),
                const SizedBox(height: 30),
                (userProfile.role == "trader_uncontracted")
                    ? TraderMainBranchSection(branch: userProfile.mainBranch!)
                    : TraderBranchesSection(branches: userProfile.branchs),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ── البطاقة الثانية: بيانات الدفع ──────────────────────────
        userProfile.paymentInfo != null
            ? TraderPaymentInfoSection(paymentInfo: userProfile.paymentInfo!)
            : const _PaymentNotSetCard(),
      ],
    );
  }

  List<Widget> _buildProfileInfoRows() {
    final profileInfo = [
      ProfileInfoItem(label: "نوع النشاط", value: userProfile.rawBusinessType!, icon: Icons.business),
      ProfileInfoItem(label: "العنوان", value: userProfile.businessAddress!, icon: Icons.location_on),
      ProfileInfoItem(label: "اسم المسئول", value: userProfile.doshManagerName!, icon: Icons.person),
      ProfileInfoItem(label: "رقم الهاتف", value: userProfile.doshManagerPhone!, icon: Icons.phone),
      ProfileInfoItem(label: "الايميل", value: userProfile.email, icon: Icons.email),
    ];

    return profileInfo
        .map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TraderProfileInfoRow(label: item.label, value: item.value, icon: item.icon),
    ))
        .toList();
  }
}

// ─── بطاقة "لم يتم تحديد طريقة الدفع" ──────────────────────────────────────

class _PaymentNotSetCard extends StatelessWidget {
  const _PaymentNotSetCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withAlpha(25), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── عنوان القسم ──────────────────────────────────────
            Text('بيانات الدفع', style: AppStyles.styleSemiBold18(context)),
            const SizedBox(height: 20),

            // ── صف "لم يتم التحديد" بنفس شكل _DetailRow ─────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.payment_outlined,
                    color: Color(0xFF10B981),
                    size: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'لم يتم التحديد بعد',
                        style: AppStyles.styleSemiBold14(context)
                            .copyWith(color: Colors.grey.shade500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'طريقة الدفع',
                        style: AppStyles.styleSemiBold12(context)
                            .copyWith(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
                // ── زر تحديد ─────────────────────────────────────
                _SelectPaymentButton(onTap: () => _showPaymentSheet(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentSheet(BuildContext context) async {
    final result = await showModalBottomSheet<PaymentInfoModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PaymentSelectionSheet(),
    );

    if (result != null && context.mounted) {
      context.read<TraderProfileCubit>().savePaymentInfo(result);
    }
  }
}

// ─── زر تحديد طريقة الدفع ───────────────────────────────────────────────────

class _SelectPaymentButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SelectPaymentButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF10B981);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: green.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: green.withAlpha(100)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_card_outlined, size: 16, color: green),
            const SizedBox(width: 6),
            Text(
              'تحديد',
              style: AppStyles.styleRegular14(context)
                  .copyWith(color: green, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Bottom Sheet الرئيسي (Step 1: اختيار → Step 2: تفاصيل) ─────────────────

class _PaymentSelectionSheet extends StatefulWidget {
  const _PaymentSelectionSheet();

  @override
  State<_PaymentSelectionSheet> createState() => _PaymentSelectionSheetState();
}

class _PaymentSelectionSheetState extends State<_PaymentSelectionSheet> {
  PaymentMethodType? _selected;
  bool _showDetails = false; // false = step1 اختيار | true = step2 تفاصيل

  // Controllers
  final _cardNumberCtrl    = TextEditingController();
  final _cardHolderCtrl    = TextEditingController();
  final _cardExpiryCtrl    = TextEditingController();
  final _cardCVVCtrl       = TextEditingController();
  final _walletPhoneCtrl   = TextEditingController();
  final _bankNameCtrl      = TextEditingController();
  final _accountHolderCtrl = TextEditingController();
  final _accountNumberCtrl = TextEditingController();

  String? _selectedEWalletProvider;

  static const List<String> _eWalletProviders = [
    'فودافون كاش', 'فوري', 'أورنج كاش', 'إتصالات كاش',
  ];

  @override
  void dispose() {
    for (final c in [
      _cardNumberCtrl, _cardHolderCtrl, _cardExpiryCtrl, _cardCVVCtrl,
      _walletPhoneCtrl, _bankNameCtrl, _accountHolderCtrl, _accountNumberCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  // ── Validate & build PaymentInfoModel ─────────────────────────────────────

  String? _validate() {
    switch (_selected!) {
      case PaymentMethodType.cash:
        return null;
      case PaymentMethodType.card:
        if (_cardNumberCtrl.text.replaceAll(' ', '').length < 16) return 'يرجى إدخال رقم بطاقة صحيح (16 رقم)';
        if (_cardHolderCtrl.text.trim().isEmpty) return 'يرجى إدخال اسم حامل البطاقة';
        if (_cardExpiryCtrl.text.trim().length < 5) return 'يرجى إدخال تاريخ الانتهاء (MM/YY)';
        if (_cardCVVCtrl.text.trim().length < 3) return 'يرجى إدخال رمز CVV الصحيح';
        return null;
      case PaymentMethodType.eWallet:
        if (_selectedEWalletProvider == null) return 'يرجى اختيار نوع المحفظة';
        if (_walletPhoneCtrl.text.trim().length != 11) return 'يرجى إدخال رقم محفظة صحيح (11 رقم)';
        return null;
      case PaymentMethodType.bankTransfer:
        if (_bankNameCtrl.text.trim().isEmpty) return 'يرجى إدخال اسم البنك';
        if (_accountHolderCtrl.text.trim().isEmpty) return 'يرجى إدخال اسم صاحب الحساب';
        if (_accountNumberCtrl.text.trim().length < 10) return 'يرجى إدخال رقم حساب صحيح';
        return null;
    }
  }

  PaymentInfoModel _buildPaymentInfo() {
    return PaymentInfoModel(
      methodType: _selected!,
      cardNumber:    _selected == PaymentMethodType.card         ? _cardNumberCtrl.text    : null,
      cardHolder:    _selected == PaymentMethodType.card         ? _cardHolderCtrl.text    : null,
      cardExpiry:    _selected == PaymentMethodType.card         ? _cardExpiryCtrl.text    : null,
      eWalletProvider: _selected == PaymentMethodType.eWallet   ? _selectedEWalletProvider : null,
      walletPhone:   _selected == PaymentMethodType.eWallet      ? _walletPhoneCtrl.text   : null,
      bankName:      _selected == PaymentMethodType.bankTransfer  ? _bankNameCtrl.text      : null,
      accountHolder: _selected == PaymentMethodType.bankTransfer  ? _accountHolderCtrl.text : null,
      accountNumber: _selected == PaymentMethodType.bankTransfer  ? _accountNumberCtrl.text : null,
    );
  }

  void _onConfirm() {
    if (!_showDetails) {
      // Step 1 → Step 2
      if (_selected == PaymentMethodType.cash) {
        // كاش مفيش تفاصيل — تأكيد مباشر
        Navigator.pop(context, _buildPaymentInfo());
      } else {
        setState(() => _showDetails = true);
      }
      return;
    }
    // Step 2 → validate ثم تأكيد
    final error = _validate();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error, textDirection: TextDirection.rtl), backgroundColor: Colors.red.shade400),
      );
      return;
    }
    Navigator.pop(context, _buildPaymentInfo());
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF10B981);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Handle ───────────────────────────────────────────
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── عنوان + زر رجوع (في step 2) ───────────────────
              Row(
                children: [
                  if (_showDetails)
                    GestureDetector(
                      onTap: () => setState(() => _showDetails = false),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: green.withAlpha(25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 16, color: green),
                      ),
                    ),
                  if (_showDetails) const SizedBox(width: 12),
                  Text(
                    _showDetails
                        ? 'بيانات ${_selected!.label}'
                        : 'اختر طريقة الدفع',
                    style: AppStyles.styleSemiBold18(context),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── المحتوى: step1 أو step2 ───────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.05, 0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                    child: child,
                  ),
                ),
                child: _showDetails
                    ? _buildDetailsForm(green)
                    : _buildMethodGrid(green),
              ),

              const SizedBox(height: 28),

              // ── زر تأكيد ────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selected == null ? null : _onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    disabledBackgroundColor: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text(
                    _showDetails
                        ? 'حفظ'
                        : (_selected == PaymentMethodType.cash ? 'تأكيد' : 'التالي'),
                    style: AppStyles.styleSemiBold14(context).copyWith(
                      color: _selected == null ? Colors.grey : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Step 1: شبكة اختيار الطريقة ───────────────────────────────────────────

  Widget _buildMethodGrid(Color green) {
    return Column(
      key: const ValueKey('grid'),
      children: PaymentMethodType.values.map((method) {
        final isSelected = _selected == method;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () => setState(() {
              _selected = method;
              _showDetails = false;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? green.withAlpha(25) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? green.withAlpha(120) : Colors.grey.shade200,
                  width: isSelected ? 1.5 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? green.withAlpha(40)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      method.icon,
                      size: 22,
                      color: isSelected ? green : Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      method.label,
                      style: AppStyles.styleSemiBold14(context).copyWith(
                        color: isSelected ? green : Colors.black87,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? green : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? green : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Step 2: فورم التفاصيل ─────────────────────────────────────────────────

  Widget _buildDetailsForm(Color primary) {
    switch (_selected!) {
      case PaymentMethodType.cash:
        return const SizedBox.shrink();

      case PaymentMethodType.card:
        return _CardForm(
          key: const ValueKey('card'),
          cardNumberCtrl: _cardNumberCtrl,
          cardHolderCtrl: _cardHolderCtrl,
          cardExpiryCtrl: _cardExpiryCtrl,
          cardCVVCtrl: _cardCVVCtrl,
        );

      case PaymentMethodType.eWallet:
        return _EWalletForm(
          key: const ValueKey('wallet'),
          providers: _eWalletProviders,
          selectedProvider: _selectedEWalletProvider,
          onProviderChanged: (v) => setState(() => _selectedEWalletProvider = v),
          phoneCtrl: _walletPhoneCtrl,
          primary: primary,
        );

      case PaymentMethodType.bankTransfer:
        return _BankForm(
          key: const ValueKey('bank'),
          bankNameCtrl: _bankNameCtrl,
          accountHolderCtrl: _accountHolderCtrl,
          accountNumberCtrl: _accountNumberCtrl,
        );
    }
  }
}

// ─── Step 2: Card Form ────────────────────────────────────────────────────────

class _CardForm extends StatelessWidget {
  final TextEditingController cardNumberCtrl;
  final TextEditingController cardHolderCtrl;
  final TextEditingController cardExpiryCtrl;
  final TextEditingController cardCVVCtrl;

  const _CardForm({
    super.key,
    required this.cardNumberCtrl,
    required this.cardHolderCtrl,
    required this.cardExpiryCtrl,
    required this.cardCVVCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: super.key,
      children: [
        _PaymentField(
          controller: cardNumberCtrl,
          labelText: 'رقم البطاقة',
          hintText: 'XXXX  XXXX  XXXX  XXXX',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, _CardNumberFormatter()],
          maxLength: 19,
          prefixIcon: Icons.credit_card_outlined,
        ),
        const SizedBox(height: 16),
        _PaymentField(
          controller: cardHolderCtrl,
          labelText: 'اسم حامل البطاقة',
          keyboardType: TextInputType.name,
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _PaymentField(
                controller: cardExpiryCtrl,
                labelText: 'تاريخ الانتهاء',
                hintText: 'MM/YY',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, _ExpiryDateFormatter()],
                maxLength: 5,
                prefixIcon: Icons.calendar_today_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _PaymentField(
                controller: cardCVVCtrl,
                labelText: 'CVV',
                hintText: '• • •',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 4,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Step 2: E-Wallet Form ────────────────────────────────────────────────────

class _EWalletForm extends StatelessWidget {
  final List<String> providers;
  final String? selectedProvider;
  final ValueChanged<String?> onProviderChanged;
  final TextEditingController phoneCtrl;
  final Color primary;

  const _EWalletForm({
    super.key,
    required this.providers,
    required this.selectedProvider,
    required this.onProviderChanged,
    required this.phoneCtrl,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF10B981);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('نوع المحفظة',
            style: AppStyles.styleSemiBold12(context)
                .copyWith(color: Colors.grey.shade500)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: providers
              .map((p) => GestureDetector(
            onTap: () => onProviderChanged(p),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selectedProvider == p
                    ? green.withAlpha(25)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedProvider == p
                      ? green.withAlpha(120)
                      : Colors.grey.shade200,
                  width: selectedProvider == p ? 1.5 : 1.0,
                ),
              ),
              child: Text(
                p,
                style: AppStyles.styleSemiBold12(context).copyWith(
                  color: selectedProvider == p ? green : Colors.black87,
                ),
              ),
            ),
          ))
              .toList(),
        ),
        const SizedBox(height: 16),
        _PaymentField(
          controller: phoneCtrl,
          labelText: 'رقم المحفظة',
          hintText: '01XXXXXXXXX',
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 11,
          prefixIcon: Icons.phone_outlined,
        ),
      ],
    );
  }
}

// ─── Step 2: Bank Form ────────────────────────────────────────────────────────

class _BankForm extends StatelessWidget {
  final TextEditingController bankNameCtrl;
  final TextEditingController accountHolderCtrl;
  final TextEditingController accountNumberCtrl;

  const _BankForm({
    super.key,
    required this.bankNameCtrl,
    required this.accountHolderCtrl,
    required this.accountNumberCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PaymentField(
          controller: bankNameCtrl,
          labelText: 'اسم البنك',
          hintText: 'مثال: البنك الأهلي المصري',
          prefixIcon: Icons.account_balance_outlined,
        ),
        const SizedBox(height: 16),
        _PaymentField(
          controller: accountHolderCtrl,
          labelText: 'اسم صاحب الحساب',
          keyboardType: TextInputType.name,
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        _PaymentField(
          controller: accountNumberCtrl,
          labelText: 'رقم الحساب / IBAN',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          prefixIcon: Icons.numbers_outlined,
        ),
      ],
    );
  }
}

// ─── Shared Field (يطابق InputDecorations + TraderProfileInfoRow style) ───────

class _PaymentField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool obscureText;
  final IconData? prefixIcon;

  const _PaymentField({
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      obscureText: obscureText,
      textDirection: TextDirection.rtl,
      style: AppStyles.styleRegular14(context),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        counterText: '',
        labelStyle: AppStyles.styleRegular14(context).copyWith(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(prefixIcon, color: const Color(0xFF10B981), size: 18),
        )
            : null,
        enabledBorder: InputDecorations.enabledBorder(),
        focusedBorder: InputDecorations.focusedBorder(),
        errorBorder: InputDecorations.errorBorder(),
        focusedErrorBorder: InputDecorations.errorBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}

// ─── Formatters ───────────────────────────────────────────────────────────────

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue old, TextEditingValue newVal) {
    final text = newVal.text.replaceAll(' ', '');
    if (text.length > 16) return old;
    final buf = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) buf.write('  ');
      buf.write(text[i]);
    }
    final out = buf.toString();
    return newVal.copyWith(text: out, selection: TextSelection.collapsed(offset: out.length));
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue old, TextEditingValue newVal) {
    var text = newVal.text.replaceAll('/', '');
    if (text.length > 4) text = text.substring(0, 4);
    final buf = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) buf.write('/');
      buf.write(text[i]);
    }
    final out = buf.toString();
    return newVal.copyWith(text: out, selection: TextSelection.collapsed(offset: out.length));
  }
}

// ─── ProfileInfoItem ─────────────────────────────────────────────────────────

class ProfileInfoItem {
  final String label;
  final String value;
  final IconData icon;
  ProfileInfoItem({required this.label, required this.value, required this.icon});
}