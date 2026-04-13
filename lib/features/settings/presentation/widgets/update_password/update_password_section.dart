import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';

class UpdatePasswordSection extends StatefulWidget {
  const UpdatePasswordSection({super.key});

  @override
  State<UpdatePasswordSection> createState() => _UpdatePasswordSectionState();
}

class _UpdatePasswordSectionState extends State<UpdatePasswordSection> {
  final _formKey = GlobalKey<FormState>();

  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;
  bool _isSaving = false;

  // ── Password strength ──────────────────────────────────────────────────────

  double get _strength {
    final v = _newCtrl.text;
    if (v.isEmpty) return 0;
    int score = 0;
    if (v.length >= 8) score++;
    if (v.contains(RegExp(r'[A-Z]'))) score++;
    if (v.contains(RegExp(r'[0-9]'))) score++;
    if (v.contains(RegExp(r'[^A-Za-z0-9]'))) score++;
    return score / 4;
  }

  Color get _strengthColor {
    if (_strength <= 0.25) return Colors.redAccent;
    if (_strength <= 0.5) return Colors.orange;
    if (_strength <= 0.75) return Colors.lightGreen;
    return const Color(0xFF1D7A5F);
  }

  String get _strengthLabel {
    if (_newCtrl.text.isEmpty) return '';
    if (_strength <= 0.25) return 'ضعيفة';
    if (_strength <= 0.5) return 'مقبولة';
    if (_strength <= 0.75) return 'جيدة';
    return 'قوية';
  }

  void _onSave({
    required String currentPassword,
    required String newPassword,
  }) {}

  void _onCancel() {}

  // ── Submit ─────────────────────────────────────────────────────────────────

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      _onSave(currentPassword: _currentCtrl.text, newPassword: _newCtrl.text);
      if (!mounted) return;
      _reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _reset() {
    _currentCtrl.clear();
    _newCtrl.clear();
    _confirmCtrl.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Icon
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFE1F5EE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_reset_rounded,
                color: Color(0xFF1D7A5F),
                size: 32,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              'تأمين حسابك',
              style: AppStyles.styleBold24(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              'يرجى إدخال كلمة المرور الحالية ومن ثم اختيار كلمة مرور جديدة قوية لحماية حسابك.',
              textAlign: TextAlign.center,
              style: AppStyles.styleMedium16(
                context,
              ).copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 28),

            // Current password
            _PasswordField(
              label: 'كلمة السر الحالية',
              controller: _currentCtrl,
              visible: _showCurrent,
              onToggle: () => setState(() => _showCurrent = !_showCurrent),
              onChanged: (_) => setState(() {}),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
            ),
            const SizedBox(height: 20),

            // New password + strength bar
            _PasswordField(
              label: 'كلمة السر الجديدة',
              controller: _newCtrl,
              visible: _showNew,
              onToggle: () => setState(() => _showNew = !_showNew),
              onChanged: (_) => setState(() {}),
              validator: (v) {
                if (v == null || v.isEmpty) return 'هذا الحقل مطلوب';
                if (v.length < 6) return 'يجب أن تكون 6 أحرف على الأقل';
                return null;
              },
              suffix: _newCtrl.text.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: _strength,
                            minHeight: 4,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation(_strengthColor),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _strengthLabel,
                          style: TextStyle(fontSize: 11, color: _strengthColor),
                        ),
                      ],
                    )
                  : null,
            ),
            const SizedBox(height: 20),

            // Confirm password
            _PasswordField(
              label: 'تأكيد كلمة السر الجديدة',
              controller: _confirmCtrl,
              visible: _showConfirm,
              onToggle: () => setState(() => _showConfirm = !_showConfirm),
              onChanged: (_) => setState(() {}),
              validator: (v) =>
                  v != _newCtrl.text ? 'كلمتا المرور غير متطابقتين' : null,
            ),
            const SizedBox(height: 32),

            // Save button
            SizedBox(
              width: double.infinity,
              child: SaveButton(onSave: _submit),
            ),
            const SizedBox(height: 10),

            // Cancel button
            SizedBox(
              width: double.infinity,

              child: CancelButton(onCancel: _onCancel),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable password field ────────────────────────────────────────────────

class _PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool visible;
  final VoidCallback onToggle;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? suffix;

  const _PasswordField({
    required this.label,
    required this.controller,
    required this.visible,
    required this.onToggle,
    required this.onChanged,
    this.validator,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.styleSemiBold14(
            context,
          ).copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: !visible,
          textAlign: TextAlign.right,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: '••••••••',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1D7A5F)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                visible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: Colors.grey[500],
              ),
              onPressed: onToggle,
            ),
          ),
        ),
        if (suffix != null) suffix!,
      ],
    );
  }
}
