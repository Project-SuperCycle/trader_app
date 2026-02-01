import 'package:flutter/material.dart';
import 'package:trader_app/core/helpers/custom_dropdown.dart';
import 'package:trader_app/core/models/trader_branch_model.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/widgets/custom_text_field.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/step_header.dart';

class AddressStep extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController notesController;

  // Branch-related
  final String userRole;
  final List<TraderBranchModel> branches;
  final String? selectedBranchName;
  final Function(String?) onBranchChanged;

  const AddressStep({
    super.key,
    required this.addressController,
    required this.notesController,
    required this.userRole,
    required this.branches,
    required this.selectedBranchName,
    required this.onBranchChanged,
  });

  static const String _contractedRole = 'trader_contracted';

  bool get _isContracted => userRole == _contractedRole;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepHeader(
          title: 'العنوان والملاحظات',
          subtitle: _isContracted
              ? 'اختر الفرع وأضف ملاحظات'
              : 'حدد عنوان الاستلام وأضف ملاحظات',
          icon: _isContracted ? Icons.store_rounded : Icons.location_on_rounded,
          stepNumber: 5,
        ),
        const SizedBox(height: 24),
        // Conditional: branch picker OR address input
        _isContracted
            ? _BranchSection(
                branches: branches,
                selectedBranchName: selectedBranchName,
                onBranchChanged: onBranchChanged,
              )
            : _AddressSection(controller: addressController),
        const SizedBox(height: 16),
        _NotesSection(controller: notesController),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Branch picker (trader_contracted)
// ─────────────────────────────────────────────────────────────
class _BranchSection extends StatelessWidget {
  final List<TraderBranchModel> branches;
  final String? selectedBranchName;
  final Function(String?) onBranchChanged;

  const _BranchSection({
    super.key,
    required this.branches,
    required this.selectedBranchName,
    required this.onBranchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'اختر الفرع',
      icon: Icons.store_rounded,
      iconColor: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown(
            options: branches.map((b) => b.branchName).toList(),
            initialValue: selectedBranchName,
            hintText: 'اختر الفرع',
            onChanged: onBranchChanged,
            width: double.infinity,
            maxHeight: 250,
            isSearchable: branches.length > 5,
            showBorder: true,
          ),
          if (selectedBranchName != null) ...[
            const SizedBox(height: 12),
            _buildConfirmationBadge(),
          ],
        ],
      ),
    );
  }

  Widget _buildConfirmationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            'تم اختيار: $selectedBranchName',
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Manual address input (default role)
// ─────────────────────────────────────────────────────────────
class _AddressSection extends StatelessWidget {
  final TextEditingController controller;

  const _AddressSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'عنوان الاستلام',
      icon: Icons.location_on_rounded,
      child: Column(
        children: [
          CustomTextField(
            label: 'العنوان',
            hint: 'أدخل عنوان الاستلام',
            controller: controller,
            keyboardType: TextInputType.text,
            icon: Icons.home_rounded,
            isArabic: true,
            enabled: true,
            borderColor: Colors.green.shade300,
          ),
          const SizedBox(height: 12),
          _buildInfoBanner(context),
        ],
      ),
    );
  }

  Widget _buildInfoBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'سيتم استلام الشحنة من هذا العنوان',
              style: AppStyles.styleMedium12(
                context,
              ).copyWith(color: Colors.blue.shade700),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Notes (shared by both roles)
// ─────────────────────────────────────────────────────────────
class _NotesSection extends StatelessWidget {
  final TextEditingController controller;

  const _NotesSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'ملاحظات إضافية (اختياري)',
      icon: Icons.note_alt_rounded,
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: AppStyles.styleMedium14(context),
        decoration: InputDecoration(
          hintText: 'أضف أي ملاحظات تريد إيصالها...',
          hintStyle: AppStyles.styleMedium14(
            context,
          ).copyWith(color: Colors.grey.shade400),
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade300, width: 2),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Shared section card wrapper
// ─────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor;

  const _SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor = const Color(0xFF4CAF50), // green.shade700 fallback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 10),
                Text(title, style: AppStyles.styleSemiBold16(context)),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }
}
