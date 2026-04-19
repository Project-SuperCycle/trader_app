import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trader_app/core/helpers/custom_dropdown.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/utils/input_decorations.dart';

class EWalletDetails extends StatelessWidget {
  final List<String> providers;
  final String? selectedProvider;
  final ValueChanged<String?> onProviderChanged;
  final TextEditingController phoneController;

  const EWalletDetails({
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
            labelStyle: AppStyles.styleRegular14(
              context,
            ).copyWith(color: Colors.grey),
            enabledBorder: InputDecorations.enabledBorder(),
            focusedBorder: InputDecorations.focusedBorder(),
            errorBorder: InputDecorations.errorBorder(),
            focusedErrorBorder: InputDecorations.errorBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
