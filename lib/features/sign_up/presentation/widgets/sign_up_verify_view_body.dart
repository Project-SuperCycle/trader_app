import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/widgets/auth/auth_main_header.dart';
import 'package:trader_app/core/widgets/auth/auth_main_layout.dart';
import 'package:trader_app/core/widgets/custom_button.dart';
import 'package:trader_app/core/widgets/rounded_container.dart';
import 'package:trader_app/features/sign_up/data/managers/sign_up_cubit/sign_up_cubit.dart';
import 'package:trader_app/features/sign_up/data/models/otp_verification_model.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/filled_rounded_pin_put.dart';
import 'package:trader_app/generated/l10n.dart';

class SignUpVerifyViewBody extends StatefulWidget {
  final String credential;

  const SignUpVerifyViewBody({super.key, required this.credential});

  @override
  State<SignUpVerifyViewBody> createState() => _SignUpVerifyViewBodyState();
}

class _SignUpVerifyViewBodyState extends State<SignUpVerifyViewBody> {
  final controller = TextEditingController();

  void handleOtpVerify() {
    final verifyModel = OtpVerificationModel(
      email: widget.credential,
      otp: controller.text,
    );
    BlocProvider.of<SignUpCubit>(context).verifyOtp(verifyModel);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          GoRouter.of(
            context,
          ).pushReplacement(EndPoints.signUpDetailsStep1View);
        }
        if (state is VerifyOtpFailure) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return AuthMainLayout(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Expanded(
                child: RoundedContainer(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      AuthMainHeader(
                        title: S.of(context).otp_verify_title,
                        subTitle: S.of(context).otp_verify_subTitle,
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.credential,
                        style: AppStyles.styleMedium18(
                          context,
                        ).copyWith(color: AppColors.subTextColor),
                      ),
                      SizedBox(height: 30),
                      FilledRoundedPinPut(controller: controller),
                      SizedBox(height: 30),
                      (state is VerifyOtpLoading)
                          ? const CustomLoadingIndicator()
                          : CustomButton(
                              title: S.of(context).otp_verify_button,
                              onPress: handleOtpVerify,
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
