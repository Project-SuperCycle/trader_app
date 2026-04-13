import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/request_change/email_field.dart';
import 'package:trader_app/features/settings/presentation/widgets/request_change/password_field.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';

class RequestEmailChangeWidget extends StatefulWidget {
  const RequestEmailChangeWidget({super.key});

  @override
  State<RequestEmailChangeWidget> createState() =>
      _RequestEmailChangeWidgetState();
}

class _RequestEmailChangeWidgetState extends State<RequestEmailChangeWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _obscurePassword = true;

  static const Color _primaryGreen = Color(0xFF1B7A4A);

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    GoRouter.of(context).push(EndPoints.confirmEmailChangeView);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // setState(() => _isLoading = true);
    // // Simulate async call
    // await Future.delayed(const Duration(milliseconds: 300));
    // setState(() => _isLoading = false);
    // widget.onSave?.call(
    //   EmailChangeRequest(
    //     newEmail: _emailCtrl.text.trim(),
    //     currentPassword: _passwordCtrl.text,
    //   ),
    // );
  }

  void _onCancel() {
    GoRouter.of(context).pop(context);
  }

  // ─────────────────────────────────────────
  //  Build
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Icon Badge ──
          _IconBadge(color: _primaryGreen),

          const SizedBox(height: 20),

          // ── Description ──
          Text(
            'يرجى إدخال البريد الإلكتروني الجديد وكلمة المرور الحالية لتحديث بيانات حسابك.',
            textAlign: TextAlign.center,
            style: AppStyles.styleMedium14(
              context,
            ).copyWith(color: AppColors.subTextColor),
          ),

          const SizedBox(height: 28),

          // ── Form Card ──
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.15),
                width: 0.75,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ── Email Field ──
                _FieldLabel(label: 'البريد الإلكتروني الجديد'),
                const SizedBox(height: 6),
                EmailField(controller: _emailCtrl, primaryGreen: _primaryGreen),

                const SizedBox(height: 16),

                // ── Password Field ──
                _FieldLabel(label: 'كلمة السر الحالية'),
                const SizedBox(height: 6),
                PasswordField(
                  controller: _passwordCtrl,
                  obscure: _obscurePassword,
                  primaryGreen: _primaryGreen,
                  onToggleObscure: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Save Button ──
          SaveButton(onSave: _submit, title: "تأكيد"),

          const SizedBox(height: 10),

          // ── Cancel Button ──
          CancelButton(onCancel: _onCancel),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Icon Badge
// ─────────────────────────────────────────────

class _IconBadge extends StatelessWidget {
  final Color color;

  const _IconBadge({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.15), width: 1),
      ),
      child: Icon(Icons.mark_email_read_outlined, color: color, size: 32),
    );
  }
}

// ─────────────────────────────────────────────
//  Field Label
// ─────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.right,
      style: AppStyles.styleMedium14(context),
    );
  }
}
