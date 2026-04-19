import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/settings/data/cubits/update_profile/update_profile_cubit.dart';
import 'package:trader_app/features/settings/data/models/update_profile_model.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';

class UpdateProfileInfo extends StatefulWidget {
  const UpdateProfileInfo({super.key});

  @override
  State<UpdateProfileInfo> createState() => _UpdateProfileInfoState();
}

class _UpdateProfileInfoState extends State<UpdateProfileInfo> {
  final _formKey = GlobalKey<FormState>();

  // ── Theme ──────────────────────────────────────────────────────────────────

  static const Color _hintColor = Color(0xFF9E9E9E);
  static const Color _borderColor = Color(0xFFE0E0E0);

  // ✅ initialized مباشرةً — مش late
  final TextEditingController _activityNameCtrl = TextEditingController();
  final TextEditingController _activityTypeCtrl = TextEditingController();
  final TextEditingController _activityAddressCtrl = TextEditingController();
  final TextEditingController _responsibleNameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await StorageServices.getUserData();

    // ✅ بدل setState نستخدم .text = مباشرةً — أخف وأسلم
    if (!mounted) return;
    _activityNameCtrl.text = user?.bussinessName ?? 'سوبر سايكل للتدوير';
    _activityAddressCtrl.text = user?.bussinessAdress ?? 'القاهرة - مصر';
    _responsibleNameCtrl.text = user?.doshMangerName ?? 'أحمد المحمد';
    _phoneCtrl.text = user?.doshMangerPhone ?? '+966 50 123 4567';
    _activityTypeCtrl.text = user?.rawBusinessType ?? 'مدرسة';
  }

  @override
  void dispose() {
    _activityNameCtrl.dispose();
    _activityAddressCtrl.dispose();
    _responsibleNameCtrl.dispose();
    _phoneCtrl.dispose();
    _activityTypeCtrl.dispose();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  InputDecoration _fieldDecoration({String? hint}) => InputDecoration(
    hintText: hint,
    hintStyle: AppStyles.styleRegular14(context).copyWith(color: _hintColor),
    filled: true,
    fillColor: Colors.transparent,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _borderColor, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _borderColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.primary, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
    ),
  );

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: AppStyles.styleMedium16(
        context,
      ).copyWith(color: AppColors.subTextColor),
    ),
  );

  Widget _buildFieldBlock({required String label, required Widget child}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_buildLabel(label), child],
      );

  void _submit() {
    if (_formKey.currentState!.validate()) {
      UpdateProfileModel profile = UpdateProfileModel(
        businessName: _activityNameCtrl.text.trim(),
        rawBusinessType: _activityTypeCtrl.text.trim(),
        doshManagerName: _responsibleNameCtrl.text.trim(),
        doshManagerPhone: _phoneCtrl.text.trim(),
        businessAddress: _activityAddressCtrl.text.trim(),
      );
      BlocProvider.of<UpdateProfileCubit>(
        context,
      ).updateProfile(profile: profile);
    }
  }

  void _cancel() {
    GoRouter.of(context).pop();
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Activity Name ─────────────────────────────────────
              _buildFieldBlock(
                label: 'اسم النشاط',
                child: TextFormField(
                  controller: _activityNameCtrl,
                  textAlign: TextAlign.right,
                  style: AppStyles.styleRegular16(
                    context,
                  ).copyWith(color: Color(0xFF222222)),
                  decoration: _fieldDecoration(),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'هذا الحقل مطلوب'
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              // ── Activity Type ─────────────────────────────────────
              _buildFieldBlock(
                label: 'نوع النشاط',
                child: TextFormField(
                  controller: _activityTypeCtrl,
                  textAlign: TextAlign.right,
                  style: AppStyles.styleRegular16(
                    context,
                  ).copyWith(color: Color(0xFF222222)),
                  decoration: _fieldDecoration(),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'هذا الحقل مطلوب'
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              // ── Activity Address ─────────────────────────────────────
              _buildFieldBlock(
                label: 'عنوان النشاط',
                child: TextFormField(
                  controller: _activityAddressCtrl,
                  textAlign: TextAlign.right,
                  style: AppStyles.styleRegular16(
                    context,
                  ).copyWith(color: Color(0xFF222222)),
                  decoration: _fieldDecoration(),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'هذا الحقل مطلوب'
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              // ── Responsible Name ─────────────────────────────────
              _buildFieldBlock(
                label: 'اسم المسؤول',
                child: TextFormField(
                  controller: _responsibleNameCtrl,
                  textAlign: TextAlign.right,
                  style: AppStyles.styleRegular16(
                    context,
                  ).copyWith(color: Color(0xFF222222)),
                  decoration: _fieldDecoration(),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'هذا الحقل مطلوب'
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              // ── Phone ─────────────────────────────────────────────
              _buildFieldBlock(
                label: 'رقم المسؤول',
                child: TextFormField(
                  controller: _phoneCtrl,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.phone,
                  style: AppStyles.styleRegular16(
                    context,
                  ).copyWith(color: Color(0xFF222222)),
                  decoration: _fieldDecoration(),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'هذا الحقل مطلوب';
                    if (v.trim().length < 7) return 'رقم الهاتف غير صحيح';
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 32),

              // ── Save Button ───────────────────────────────────────
              BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is UpdateProfileSuccess) {
                    GoRouter.of(context).pop();
                  }
                  if (state is UpdateProfileFailure) {
                    CustomSnackBar.showError(context, state.errMessage);
                  }
                },
                builder: (context, state) {
                  if (state is UpdateProfileLoading) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CustomLoadingIndicator(color: AppColors.primary),
                      ),
                    );
                  }
                  return SaveButton(onSave: _submit);
                },
              ),

              const SizedBox(height: 12),

              // ── Cancel Button ─────────────────────────────────────
              CancelButton(onCancel: _cancel),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
