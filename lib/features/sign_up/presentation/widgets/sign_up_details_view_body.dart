import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:supercycle/core/data/egypt_locations_data.dart';
import 'package:supercycle/core/helpers/custom_dropdown.dart';
import 'package:supercycle/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle/core/helpers/custom_snack_bar.dart';
import 'package:supercycle/core/routes/end_points.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/core/utils/input_decorations.dart';
import 'package:supercycle/core/widgets/auth/auth_main_layout.dart';
import 'package:supercycle/core/widgets/custom_button.dart';
import 'package:supercycle/core/widgets/custom_text_form_field.dart';
import 'package:supercycle/core/widgets/rounded_container.dart';
import 'package:supercycle/features/sign_up/data/managers/sign_up_cubit/sign_up_cubit.dart';
import 'package:supercycle/features/sign_up/data/models/business_information_model.dart';
import 'package:supercycle/features/sign_up/presentation/widgets/privacy_policy_checkbox.dart';
import 'package:supercycle/generated/l10n.dart';

class SignUpDetailsViewBody extends StatefulWidget {
  const SignUpDetailsViewBody({super.key});

  @override
  State<SignUpDetailsViewBody> createState() => _SignUpDetailsViewBodyState();
}

class _SignUpDetailsViewBodyState extends State<SignUpDetailsViewBody> {
  final _formKey = GlobalKey<FormState>();
  bool isAgreed = false;
  String completePhoneNumber = ''; // لحفظ رقم التليفون الكامل مع كود الدولة
  String? selectedGovernorate; // المحافظة المختارة
  String? selectedDistrict; // المنطقة المختارة
  List<String> availableDistricts = []; // المناطق المتاحة حسب المحافظة

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

    // التحقق من اختيار المحافظة والمنطقة
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
        doshMangerPhone: completePhoneNumber.substring(
          2,
        ), // استخدام الرقم الكامل
      );
      BlocProvider.of<SignUpCubit>(context).completeSignup(businessInformation);
    }
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

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
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          S.of(context).entity_information,
                          style: AppStyles.styleSemiBold20(context),
                        ),
                      ),
                      SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        child: Column(
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
                            // Dropdown للمحافظات
                            CustomDropdown(
                              options: EgyptLocationsData.governorates,
                              hintText: 'اختر المحافظة',
                              initialValue: selectedGovernorate,
                              onChanged: (value) {
                                setState(() {
                                  selectedGovernorate = value;
                                  selectedDistrict =
                                      null; // إعادة تعيين المنطقة
                                  if (value != null) {
                                    availableDistricts =
                                        EgyptLocationsData.getDistrictsByGovernorate(
                                          value,
                                        );
                                  } else {
                                    availableDistricts = [];
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            // Dropdown للمناطق
                            CustomDropdown(
                              options: availableDistricts,
                              hintText: 'اختر المنطقة',
                              initialValue: selectedDistrict,
                              onChanged: (value) {
                                setState(() {
                                  selectedDistrict = value;
                                });
                              },
                              isSearchable: true, // إضافة خاصية البحث للمناطق
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
                            // استخدام IntlPhoneField مع كود مصر فقط
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
                                  enabledBorder:
                                      InputDecorations.enabledBorder(),
                                  focusedBorder:
                                      InputDecorations.focusedBorder(),
                                  errorBorder: InputDecorations.errorBorder(),
                                  focusedErrorBorder:
                                      InputDecorations.errorBorder(),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ), // إضافة padding للـ content
                                ),
                                languageCode: "ar", // اللغة العربية
                                initialCountryCode: 'EG', // مصر فقط
                                countries: countries
                                    .where((country) => country.code == 'EG')
                                    .toList(), // فلترة مصر فقط
                                showDropdownIcon: false, // إخفاء السهم
                                disableLengthCheck:
                                    false, // تفعيل فحص طول الرقم
                                dropdownTextStyle: AppStyles.styleRegular14(
                                  context,
                                ),
                                flagsButtonPadding: const EdgeInsets.only(
                                  left: 12,
                                  right: 8,
                                ), // padding لجزء العلم والكود
                                onChanged: (phone) {
                                  // حفظ الرقم الكامل مع كود الدولة
                                  completePhoneNumber = phone.completeNumber;
                                },
                                invalidNumberMessage: 'رقم الهاتف غير صحيح',
                              ),
                            ),
                            const SizedBox(height: 20),
                            PrivacyPolicyCheckbox(
                              initialValue: isAgreed,
                              onChanged: (bool value) {
                                setState(() {
                                  isAgreed = value;
                                });
                              },
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
