import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/services/auth_manager_services.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/settings/data/cubits/confirm_email_Change/confirm_email_change_cubit.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/filled_rounded_pin_put.dart';

class ConfirmEmailChangeWidget extends StatefulWidget {
  const ConfirmEmailChangeWidget({super.key});

  @override
  State<ConfirmEmailChangeWidget> createState() =>
      _ConfirmEmailChangeWidgetState();
}

class _ConfirmEmailChangeWidgetState extends State<ConfirmEmailChangeWidget> {
  final _otpController = TextEditingController();
  final bool _isLoading = false;

  final AuthManager _authManager = AuthManager();

  static const Color _primaryGreen = AppColors.primary;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final otp = _otpController.text;
    if (otp.length != 6 || _isLoading) return;
    BlocProvider.of<ConfirmEmailChangeCubit>(
      context,
    ).confirmEmailChange(otp: otp);
  }

  void _cancel() {
    GoRouter.of(context).pop();
  }

  Future<void> _performLogout(BuildContext context) async {
    // إغلاق الـ dialog
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    // إغلاق الـ drawer
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    // تنفيذ عملية تسجيل الخروج
    final success = await _authManager.logout();

    if (success && context.mounted) {
      // التنقل إلى الصفحة الرئيسية وإعادة بناء كل شيء
      context.go(EndPoints.homeView);

      // إظهار رسالة نجاح
      CustomSnackBar.showSuccess(context, 'تم تسجيل الخروج بنجاح');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Icon Badge ──
        Align(
          alignment: Alignment.center,
          child: _VerifyIconBadge(primaryGreen: _primaryGreen),
        ),

        const SizedBox(height: 22),

        // ── Title ──
        Text(
          'أدخل رمز التحقق',
          textAlign: TextAlign.center,
          style: AppStyles.styleBold24(
            context,
          ).copyWith(color: AppColors.primary),
        ),

        const SizedBox(height: 12),

        // ── Subtitle ──
        Text(
          'لقد أرسلنا رمزاً مكوناً من 6 أرقام إلى بريدك الإلكتروني الجديد. يرجى إدخاله أدناه للمتابعة.',
          textAlign: TextAlign.center,
          style: AppStyles.styleMedium16(
            context,
          ).copyWith(color: Colors.grey[600]),
        ),

        const SizedBox(height: 32),

        // ── OTP Input ──
        FilledRoundedPinPut(controller: _otpController),

        const SizedBox(height: 32),

        // ── Confirm Button ──
        BlocConsumer<ConfirmEmailChangeCubit, ConfirmEmailChangeState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is ConfirmEmailChangeFailure) {
              CustomSnackBar.showError(context, state.errMessage);
            }
            if (state is ConfirmEmailChangeSuccess) {
              _performLogout(context);
            }
          },
          builder: (context, state) {
            if (state is ConfirmEmailChangeLoading) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CustomLoadingIndicator(color: AppColors.primary),
                ),
              );
            }
            return SaveButton(onSave: _submit, title: 'تأكيد');
          },
        ),

        const SizedBox(height: 10),

        // ── Cancel Button ──
        CancelButton(onCancel: _cancel),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Icon Badge  (envelope + shield overlay)
// ─────────────────────────────────────────────

class _VerifyIconBadge extends StatelessWidget {
  final Color primaryGreen;

  const _VerifyIconBadge({required this.primaryGreen});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 88,
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryGreen.withValues(alpha: 0.12),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.mark_email_unread_outlined,
              color: primaryGreen,
              size: 36,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: primaryGreen,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.verified_user_outlined,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
