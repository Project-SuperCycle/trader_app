import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trader_app/core/helpers/custom_dropdown.dart';
import 'package:trader_app/core/helpers/date_time_picker_util.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/step_header.dart';

class DateTimeStep extends StatefulWidget {
  final DateTime? initialDateTime;

  final String? selectedFinanceMethod;
  final Function(DateTime?) onDateTimeChanged;

  final Function(String?) onFinanceChanged;

  const DateTimeStep({
    super.key,
    required this.initialDateTime,
    required this.onDateTimeChanged,
    required this.selectedFinanceMethod,
    required this.onFinanceChanged,
  });

  @override
  State<DateTimeStep> createState() => _DateTimeStepState();
}

class _DateTimeStepState extends State<DateTimeStep> {
  DateTime? _selectedDateTime;

  String? _selectedFinanceMethod;

  List<String> financeMethods = [];

  Future<void> _loadFinances() async {
    final finances = await StorageServices.getFinancesMethods();
    if (!mounted) return;

    final bool cash = finances!.cash;
    final bool bankTransfer = finances.bankTransfer.enabled;
    final bool eWallet = finances.wallet.enabled;

    setState(() {
      financeMethods = [
        if (cash) 'تحصيل نقدي',
        if (bankTransfer) 'تحويل بنكي',
        if (eWallet) 'محفظة إلكترونية',
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFinances();
    _selectedDateTime = widget.initialDateTime;
  }

  @override
  void didUpdateWidget(DateTimeStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDateTime != oldWidget.initialDateTime) {
      setState(() => _selectedDateTime = widget.initialDateTime);
    }
  }

  Future<void> _selectDate() async {
    final DateTime? result = await DateTimePickerHelper.selectDateTime(
      context,
      currentSelectedDateTime: _selectedDateTime,
    );
    if (result != null) {
      setState(() => _selectedDateTime = result);
      widget.onDateTimeChanged(result);
    }
  }

  Future<void> _selectFinance() async {
    if (_selectedFinanceMethod != null) {
      String method = '';
      if (_selectedFinanceMethod == 'تحصيل نقدي') {
        method = 'cash';
      } else if (_selectedFinanceMethod == 'تحويل بنكي') {
        method = 'bankTransfer';
      } else if (_selectedFinanceMethod == 'محفظة إلكترونية') {
        method = 'wallet';
      }
      widget.onFinanceChanged(method);
    }
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'لم يتم تحديد الموعد';
    final date = dateTime.copyWith(hour: dateTime.hour - 2);
    return DateFormat('dd/MM/yyyy  HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepHeader(
          title: 'الموعد و التحصيل',
          subtitle: 'حدد التاريخ و طريقة تحصيل النقدية المناسبين',
          icon: Icons.calendar_month_rounded,
          stepNumber: 3,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
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
              Text('موعد الاستلام', style: AppStyles.styleMedium16(context)),
              const SizedBox(height: 8),
              _buildDatePicker(),
              const SizedBox(height: 20),
              Text('طريقة التحصيل', style: AppStyles.styleMedium16(context)),
              const SizedBox(height: 8),
              CustomDropdown(
                options: financeMethods,
                onChanged: (value) {
                  setState(() {
                    _selectedFinanceMethod = value;
                  });
                  _selectFinance();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoCard(),
      ],
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _selectDate,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _formatDate(_selectedDateTime),
                style: AppStyles.styleMedium14(context),
              ),
            ),
            Icon(Icons.edit, color: AppColors.primary, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'سيتم الاستلام في الموعد المحدد فوراً',
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
