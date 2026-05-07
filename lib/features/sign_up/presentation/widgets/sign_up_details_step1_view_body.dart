import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:trader_app/core/data/egypt_locations_data.dart';
import 'package:trader_app/core/helpers/custom_dropdown.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/utils/input_decorations.dart';
import 'package:trader_app/core/widgets/auth/auth_main_layout.dart';
import 'package:trader_app/core/widgets/custom_button.dart';
import 'package:trader_app/core/widgets/custom_text_form_field.dart';
import 'package:trader_app/core/widgets/rounded_container.dart';
import 'package:trader_app/features/sign_up/data/models/business_information_model.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/privacy_policy_checkbox.dart';
import 'package:trader_app/generated/l10n.dart';

class SignUpDetailsStep1ViewBody extends StatefulWidget {
  const SignUpDetailsStep1ViewBody({super.key});

  @override
  State<SignUpDetailsStep1ViewBody> createState() =>
      _SignUpDetailsStep1ViewBodyState();
}

class _SignUpDetailsStep1ViewBodyState
    extends State<SignUpDetailsStep1ViewBody> {
  final _formKey = GlobalKey<FormState>();
  bool isAgreed = false;
  String completePhoneNumber = '';
  String? selectedGovernorate;
  String? selectedDistrict;
  List<String> availableDistricts = [];

  final _controllers = {
    'businessName': TextEditingController(),
    'rawBusinessType': TextEditingController(),
    'businessAddress': TextEditingController(),
    'doshManagerName': TextEditingController(),
    'doshManagerPhone': TextEditingController(),
  };

  void handleCompleteSignUp() {
    if (!isAgreed) {
      CustomSnackBar.showWarning(
        context,
        S.of(context).privacy_policy_required,
      );
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

    if (_formKey.currentState!.validate()) {
      final businessInformation = BusinessInformationModel(
        bussinessName: _controllers['businessName']!.text,
        rawBusinessType: _controllers['rawBusinessType']!.text,
        bussinessAdress:
            '$selectedGovernorate - $selectedDistrict - ${_controllers['businessAddress']!.text}',
        doshMangerName: _controllers['doshManagerName']!.text,
        doshMangerPhone: completePhoneNumber.substring(2),
      );

      GoRouter.of(
        context,
      ).push(EndPoints.signUpDetailsStep2View, extra: businessInformation);
    }
  }

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
                                  ? EgyptLocationsData.getDistrictsByGovernorate(
                                      value,
                                    )
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
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: IntlPhoneField(
                            controller: _controllers['doshManagerPhone'],
                            style: AppStyles.styleRegular14(context),
                            decoration: InputDecoration(
                              labelText: S.of(context).administrator_phone,
                              labelStyle: AppStyles.styleRegular14(
                                context,
                              ).copyWith(color: Colors.grey),
                              enabledBorder: InputDecorations.enabledBorder(),
                              focusedBorder: InputDecorations.focusedBorder(),
                              errorBorder: InputDecorations.errorBorder(),
                              focusedErrorBorder:
                                  InputDecorations.errorBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            languageCode: "ar",
                            initialCountryCode: 'EG',
                            countries: countries
                                .where((c) => c.code == 'EG')
                                .toList(),
                            showDropdownIcon: false,
                            disableLengthCheck: false,
                            dropdownTextStyle: AppStyles.styleRegular14(
                              context,
                            ),
                            flagsButtonPadding: const EdgeInsets.only(
                              left: 12,
                              right: 8,
                            ),
                            onChanged: (phone) {
                              completePhoneNumber = phone.completeNumber;
                            },
                            invalidNumberMessage: 'رقم الهاتف غير صحيح',
                          ),
                        ),
                        const SizedBox(height: 20),
                        PrivacyPolicyCheckbox(
                          initialValue: isAgreed,
                          onChanged: (v) => setState(() => isAgreed = v),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              title: "التالي",
                              onPress: handleCompleteSignUp,
                              enabled: isAgreed,
                            ),
                          ],
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
  }
}
