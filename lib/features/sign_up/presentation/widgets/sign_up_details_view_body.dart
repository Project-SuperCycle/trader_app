import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:trader_app/core/data/egypt_locations_data.dart';
import 'package:trader_app/core/helpers/custom_dropdown.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/utils/input_decorations.dart';
import 'package:trader_app/core/widgets/auth/auth_main_layout.dart';
import 'package:trader_app/core/widgets/custom_button.dart';
import 'package:trader_app/core/widgets/custom_text_form_field.dart';
import 'package:trader_app/core/widgets/rounded_container.dart';
import 'package:trader_app/features/sign_up/data/managers/sign_up_cubit/sign_up_cubit.dart';
import 'package:trader_app/features/sign_up/data/models/business_information_model.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/privacy_policy_checkbox.dart';
import 'package:trader_app/generated/l10n.dart';

// ─── نماذج طرق الدفع ──────────────────────────────────────────────────────────

enum PaymentMethodType { cash, card, eWallet, bankTransfer }

class PaymentMethodOption {
  final PaymentMethodType type;
  final String label;
  final String subtitle;
  final IconData icon;

  const PaymentMethodOption({
    required this.type,
    required this.label,
    required this.subtitle,
    required this.icon,
  });
}

// ─── الـ Widget الرئيسي ────────────────────────────────────────────────────────

class SignUpDetailsViewBody extends StatefulWidget {
  const SignUpDetailsViewBody({super.key});

  @override
  State<SignUpDetailsViewBody> createState() => _SignUpDetailsViewBodyState();
}

class _SignUpDetailsViewBodyState extends State<SignUpDetailsViewBody> {
  final _formKey = GlobalKey<FormState>();
  bool isAgreed = false;
  String completePhoneNumber = '';
  String? selectedGovernorate;
  String? selectedDistrict;
  List<String> availableDistricts = [];

  // ── Payment State ──────────────────────────────────────────────
  PaymentMethodType? selectedPaymentMethod;
  String? selectedEWalletProvider;

  final _controllers = {
    'businessName': TextEditingController(),
    'rawBusinessType': TextEditingController(),
    'businessAddress': TextEditingController(),
    'doshManagerName': TextEditingController(),
    'doshManagerPhone': TextEditingController(),
    // Card fields
    'cardNumber': TextEditingController(),
    'cardHolder': TextEditingController(),
    'cardExpiry': TextEditingController(),
    'cardCVV': TextEditingController(),
    // E-Wallet fields
    'walletPhone': TextEditingController(),
    // Bank Transfer fields
    'bankName': TextEditingController(),
    'accountHolder': TextEditingController(),
    'accountNumber': TextEditingController(),
  };

  static const List<PaymentMethodOption> _paymentOptions = [
    PaymentMethodOption(
      type: PaymentMethodType.cash,
      label: 'كاش',
      subtitle: 'الدفع نقداً عند التسليم',
      icon: Icons.payments_outlined,
    ),
    PaymentMethodOption(
      type: PaymentMethodType.card,
      label: 'بطاقة بنكية',
      subtitle: 'Visa / Mastercard / Meeza',
      icon: Icons.credit_card_outlined,
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

  static const List<String> _eWalletProviders = [
    'فودافون كاش',
    'فوري',
    'أورنج كاش',
    'إتصالات كاش',
  ];

  // ─── Validation طرق الدفع ──────────────────────────────────────

  String? _validatePaymentFields() {
    if (selectedPaymentMethod == null) {
      return 'يرجى اختيار طريقة الدفع';
    }

    switch (selectedPaymentMethod!) {
      case PaymentMethodType.cash:
        return null;

      case PaymentMethodType.card:
        final cardNum =
        _controllers['cardNumber']!.text.replaceAll(' ', '').trim();
        if (cardNum.isEmpty) return 'يرجى إدخال رقم البطاقة';
        if (cardNum.length < 16) return 'رقم البطاقة يجب أن يكون 16 رقم';
        if (_controllers['cardHolder']!.text.trim().isEmpty)
          return 'يرجى إدخال اسم حامل البطاقة';
        if (_controllers['cardExpiry']!.text.trim().length < 5)
          return 'يرجى إدخال تاريخ الانتهاء بشكل صحيح (MM/YY)';
        if (_controllers['cardCVV']!.text.trim().length < 3)
          return 'يرجى إدخال CVV صحيح';
        return null;

      case PaymentMethodType.eWallet:
        if (selectedEWalletProvider == null)
          return 'يرجى اختيار نوع المحفظة الإلكترونية';
        final walletPhone = _controllers['walletPhone']!.text.trim();
        if (walletPhone.isEmpty) return 'يرجى إدخال رقم المحفظة';
        if (walletPhone.length != 11) return 'رقم المحفظة يجب أن يكون 11 رقم';
        return null;

      case PaymentMethodType.bankTransfer:
        if (_controllers['bankName']!.text.trim().isEmpty)
          return 'يرجى إدخال اسم البنك';
        if (_controllers['accountHolder']!.text.trim().isEmpty)
          return 'يرجى إدخال اسم صاحب الحساب';
        final accNum = _controllers['accountNumber']!.text.trim();
        if (accNum.isEmpty) return 'يرجى إدخال رقم الحساب';
        if (accNum.length < 10)
          return 'رقم الحساب يجب أن يكون 10 أرقام على الأقل';
        return null;
    }
  }

  // ─── الإنشاء ───────────────────────────────────────────────────

  void handleCompleteSignUp() {
    if (!isAgreed) {
      CustomSnackBar.showWarning(
          context, S.of(context).privacy_policy_required);
      return;
    }
    if (selectedGovernorate == null) {
      CustomSnackBar.showWarning(context, 'يرجى اختيار المحافظة');
      return;
    }
    if (selectedDistrict == null) {
      CustomSnackBar.showWarning(context, 'يرجى اختيار المنطقة');
      return;
    }

    final paymentError = _validatePaymentFields();
    if (paymentError != null) {
      CustomSnackBar.showWarning(context, paymentError);
      return;
    }

    if (_formKey.currentState!.validate()) {
      final paymentDetails = _buildPaymentDetails();

      final businessInformation = BusinessInformationModel(
        bussinessName: _controllers['businessName']!.text,
        rawBusinessType: _controllers['rawBusinessType']!.text,
        bussinessAdress:
        '$selectedGovernorate - $selectedDistrict - ${_controllers['businessAddress']!.text}',
        doshMangerName: _controllers['doshManagerName']!.text,
        doshMangerPhone: completePhoneNumber.substring(2),
      );

      BlocProvider.of<SignUpCubit>(context).completeSignup(businessInformation);
    }
  }

  Map<String, String> _buildPaymentDetails() {
    switch (selectedPaymentMethod!) {
      case PaymentMethodType.cash:
        return {'method': 'cash'};
      case PaymentMethodType.card:
        return {
          'method': 'card',
          'cardNumber':
          _controllers['cardNumber']!.text.replaceAll(' ', '').trim(),
          'cardHolder': _controllers['cardHolder']!.text.trim(),
          'expiry': _controllers['cardExpiry']!.text.trim(),
        };
      case PaymentMethodType.eWallet:
        return {
          'method': 'e_wallet',
          'provider': selectedEWalletProvider!,
          'phone': _controllers['walletPhone']!.text.trim(),
        };
      case PaymentMethodType.bankTransfer:
        return {
          'method': 'bank_transfer',
          'bankName': _controllers['bankName']!.text.trim(),
          'accountHolder': _controllers['accountHolder']!.text.trim(),
          'accountNumber': _controllers['accountNumber']!.text.trim(),
        };
    }
  }

  @override
  void dispose() {
    _controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  // ─── Build ────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is CompleteSignUpSuccess) {
          CustomSnackBar.showSuccess(context, state.message);
          GoRouter.of(context).pushReplacement(EndPoints.signInView);
        }
        if (state is CompleteSignUpFailure) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
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
                          S.of(context).entity_information,
                          style: AppStyles.styleSemiBold20(context),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── بيانات الجهة ──────────────────────────
                            CustomTextFormField(
                              controller: _controllers['businessName'],
                              labelText: S.of(context).entity_name,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: _controllers['rawBusinessType'],
                              labelText: S.of(context).entity_type,
                            ),
                            const SizedBox(height: 20),
                            CustomDropdown(
                              options: EgyptLocationsData.governorates,
                              hintText: 'اختر المحافظة',
                              initialValue: selectedGovernorate,
                              onChanged: (value) {
                                setState(() {
                                  selectedGovernorate = value;
                                  selectedDistrict = null;
                                  availableDistricts = value != null
                                      ? EgyptLocationsData
                                      .getDistrictsByGovernorate(value)
                                      : [];
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomDropdown(
                              options: availableDistricts,
                              hintText: 'اختر المنطقة',
                              initialValue: selectedDistrict,
                              onChanged: (value) =>
                                  setState(() => selectedDistrict = value),
                              isSearchable: true,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: _controllers['businessAddress'],
                              labelText: S.of(context).entity_address,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: _controllers['doshManagerName'],
                              labelText: S.of(context).administrator_name,
                            ),
                            const SizedBox(height: 20),

                            // ── رقم المسؤول ──────────────────────────
                            Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: IntlPhoneField(
                                controller: _controllers['doshManagerPhone'],
                                style: AppStyles.styleRegular14(context),
                                decoration: InputDecoration(
                                  labelText:
                                  S.of(context).administrator_phone,
                                  labelStyle:
                                  AppStyles.styleRegular14(context)
                                      .copyWith(color: Colors.grey),
                                  enabledBorder:
                                  InputDecorations.enabledBorder(),
                                  focusedBorder:
                                  InputDecorations.focusedBorder(),
                                  errorBorder:
                                  InputDecorations.errorBorder(),
                                  focusedErrorBorder:
                                  InputDecorations.errorBorder(),
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                ),
                                languageCode: "ar",
                                initialCountryCode: 'EG',
                                countries: countries
                                    .where((c) => c.code == 'EG')
                                    .toList(),
                                showDropdownIcon: false,
                                disableLengthCheck: false,
                                dropdownTextStyle:
                                AppStyles.styleRegular14(context),
                                flagsButtonPadding: const EdgeInsets.only(
                                    left: 12, right: 8),
                                onChanged: (phone) {
                                  completePhoneNumber = phone.completeNumber;
                                },
                                invalidNumberMessage: 'رقم الهاتف غير صحيح',
                              ),
                            ),

                            const SizedBox(height: 10),

                            // ══════════════════════════════════════════
                            // قسم طريقة الدفع
                            // ══════════════════════════════════════════
                            _PaymentMethodSection(
                              paymentOptions: _paymentOptions,
                              selectedMethod: selectedPaymentMethod,
                              selectedEWalletProvider: selectedEWalletProvider,
                              eWalletProviders: _eWalletProviders,
                              controllers: _controllers,
                              onMethodChanged: (type) {
                                setState(() {
                                  selectedPaymentMethod = type;
                                  selectedEWalletProvider = null;
                                });
                              },
                              onEWalletProviderChanged: (p) =>
                                  setState(() => selectedEWalletProvider = p),
                            ),

                            const SizedBox(height: 20),

                            // ── الموافقة على الشروط ──────────────────
                            PrivacyPolicyCheckbox(
                              initialValue: isAgreed,
                              onChanged: (v) => setState(() => isAgreed = v),
                            ),
                            const SizedBox(height: 30),

                            (state is CompleteSignUpLoading)
                                ? const CustomLoadingIndicator()
                                : CustomButton(
                              title: S.of(context).signUp_button,
                              onPress: handleCompleteSignUp,
                              enabled: isAgreed,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Widget: قسم طريقة الدفع ─────────────────────────────────────────────────

class _PaymentMethodSection extends StatelessWidget {
  final List<PaymentMethodOption> paymentOptions;
  final PaymentMethodType? selectedMethod;
  final String? selectedEWalletProvider;
  final List<String> eWalletProviders;
  final Map<String, TextEditingController> controllers;
  final ValueChanged<PaymentMethodType> onMethodChanged;
  final ValueChanged<String?> onEWalletProviderChanged;

  const _PaymentMethodSection({
    required this.paymentOptions,
    required this.selectedMethod,
    required this.selectedEWalletProvider,
    required this.eWalletProviders,
    required this.controllers,
    required this.onMethodChanged,
    required this.onEWalletProviderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─ عنوان القسم — نفس استايل عنوان "بيانات الجهة" ──────
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'طريقة الدفع',
            style: AppStyles.styleSemiBold20(context),
          ),
        ),
        const SizedBox(height: 16),

        // ─ Dropdown اختيار طريقة الدفع ─────────────────────────
        CustomDropdown(
          options: paymentOptions.map((o) => o.label).toList(),
          hintText: 'اختر طريقة الدفع',
          initialValue: selectedMethod != null
              ? paymentOptions
              .firstWhere((o) => o.type == selectedMethod)
              .label
              : null,
          onChanged: (value) {
            if (value == null) return;
            final option =
            paymentOptions.firstWhere((o) => o.label == value);
            onMethodChanged(option.type);
          },
        ),

        // ─ التفاصيل المتغيرة حسب الاختيار ──────────────────────
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => SizeTransition(
            sizeFactor: animation,
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: _buildPaymentDetails(context),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails(BuildContext context) {
    if (selectedMethod == null) return const SizedBox.shrink();

    switch (selectedMethod!) {
      case PaymentMethodType.cash:
        return _CashDetails(key: const ValueKey('cash'));

      case PaymentMethodType.card:
        return _CardDetails(
          key: const ValueKey('card'),
          controllers: controllers,
        );

      case PaymentMethodType.eWallet:
        return _EWalletDetails(
          key: const ValueKey('ewallet'),
          providers: eWalletProviders,
          selectedProvider: selectedEWalletProvider,
          onProviderChanged: onEWalletProviderChanged,
          phoneController: controllers['walletPhone']!,
        );

      case PaymentMethodType.bankTransfer:
        return _BankTransferDetails(
          key: const ValueKey('bank'),
          bankNameController: controllers['bankName']!,
          accountHolderController: controllers['accountHolder']!,
          accountNumberController: controllers['accountNumber']!,
        );
    }
  }
}

// ─── تفاصيل الدفع: كاش ───────────────────────────────────────────────────────

class _CashDetails extends StatelessWidget {
  const _CashDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // كاش لا يحتاج حقول إضافية
  }
}

// ─── تفاصيل الدفع: بطاقة بنكية ───────────────────────────────────────────────

class _CardDetails extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const _CardDetails({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        // رقم البطاقة
        TextFormField(
          controller: controllers['cardNumber'],
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            _CardNumberFormatter(),
          ],
          maxLength: 19,
          style: AppStyles.styleRegular14(context),
          decoration: InputDecoration(
            labelText: 'رقم البطاقة',
            hintText: 'XXXX  XXXX  XXXX  XXXX',
            counterText: '',
            labelStyle:
            AppStyles.styleRegular14(context).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 20),

        // اسم حامل البطاقة
        TextFormField(
          controller: controllers['cardHolder'],
          keyboardType: TextInputType.name,
          style: AppStyles.styleRegular14(context),
          decoration: InputDecoration(
            labelText: 'اسم حامل البطاقة',
            hintText: 'الاسم كما هو على البطاقة',
            labelStyle:
            AppStyles.styleRegular14(context).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 20),

        // تاريخ الانتهاء + CVV في صف واحد
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controllers['cardExpiry'],
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _ExpiryDateFormatter(),
                ],
                maxLength: 5,
                style: AppStyles.styleRegular14(context),
                decoration: InputDecoration(
                  labelText: 'تاريخ الانتهاء',
                  hintText: 'MM/YY',
                  counterText: '',
                  labelStyle: AppStyles.styleRegular14(context)
                      .copyWith(color: Colors.grey),
                  enabledBorder: InputDecorations.enabledBorder(),
                  focusedBorder: InputDecorations.focusedBorder(),
                  errorBorder: InputDecorations.errorBorder(),
                  focusedErrorBorder: InputDecorations.errorBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: controllers['cardCVV'],
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 4,
                obscureText: true,
                style: AppStyles.styleRegular14(context),
                decoration: InputDecoration(
                  labelText: 'CVV',
                  hintText: '• • •',
                  counterText: '',
                  labelStyle: AppStyles.styleRegular14(context)
                      .copyWith(color: Colors.grey),
                  enabledBorder: InputDecorations.enabledBorder(),
                  focusedBorder: InputDecorations.focusedBorder(),
                  errorBorder: InputDecorations.errorBorder(),
                  focusedErrorBorder: InputDecorations.errorBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── تفاصيل الدفع: محفظة إلكترونية ─────────────────────────────────────────

class _EWalletDetails extends StatelessWidget {
  final List<String> providers;
  final String? selectedProvider;
  final ValueChanged<String?> onProviderChanged;
  final TextEditingController phoneController;

  const _EWalletDetails({
    super.key,
    required this.providers,
    required this.selectedProvider,
    required this.onProviderChanged,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // ── Dropdown اختيار نوع المحفظة ──────────────────────
        CustomDropdown(
          options: providers,
          hintText: 'اختر نوع المحفظة',
          initialValue: selectedProvider,
          onChanged: onProviderChanged,
        ),
        const SizedBox(height: 20),

        // ── رقم المحفظة ──────────────────────────────────────
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 11,
          style: AppStyles.styleRegular14(context),
          decoration: InputDecoration(
            labelText: 'رقم المحفظة',
            hintText: '01XXXXXXXXX',
            counterText: '',
            labelStyle:
            AppStyles.styleRegular14(context).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

// ─── تفاصيل الدفع: تحويل بنكي ────────────────────────────────────────────────

class _BankTransferDetails extends StatelessWidget {
  final TextEditingController bankNameController;
  final TextEditingController accountHolderController;
  final TextEditingController accountNumberController;

  const _BankTransferDetails({
    super.key,
    required this.bankNameController,
    required this.accountHolderController,
    required this.accountNumberController,
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
            labelStyle:
            AppStyles.styleRegular14(context).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            labelStyle:
            AppStyles.styleRegular14(context).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: accountNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: AppStyles.styleRegular14(context),
          decoration: InputDecoration(
            labelText: 'رقم الحساب / IBAN',
            hintText: 'أدخل رقم الحساب البنكي',
            labelStyle:
            AppStyles.styleRegular14(context).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

// ─── Formatters ───────────────────────────────────────────────────────────────

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(' ', '');
    if (text.length > 16) return oldValue;
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write('  ');
      buffer.write(text[i]);
    }
    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length > 4) text = text.substring(0, 4);
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }
    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}