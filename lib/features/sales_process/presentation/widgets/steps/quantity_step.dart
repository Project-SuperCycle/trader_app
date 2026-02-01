import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/sales_process/data/models/dosh_item_model.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/step_header.dart';

class QuantityStep extends StatelessWidget {
  final List<DoshItemModel> products;

  const QuantityStep({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepHeader(
          title: 'تحديد الكميات',
          subtitle: 'الكميات محددة مع كل منتج',
          icon: Icons.format_list_numbered_rounded,
          stepNumber: 2,
        ),
        const SizedBox(height: 24),
        if (products.isEmpty)
          _buildEmptyState()
        else
          Column(
            children: products.asMap().entries.map((entry) {
              return _ProductQuantityCard(
                index: entry.key,
                product: entry.value,
              );
            }).toList(),
          ),
        const SizedBox(height: 16),
        _buildInfoCard(context),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.inventory_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'لم يتم إضافة منتجات بعد',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
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
              'يمكنك تعديل الكميات من الخطوة السابقة',
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

class _ProductQuantityCard extends StatelessWidget {
  final int index;
  final DoshItemModel product;

  const _ProductQuantityCard({
    super.key,
    required this.index,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIndexBadge(context),
          const SizedBox(width: 12),
          Expanded(child: _buildProductInfo(context)),
          const Icon(Icons.check_circle, color: Colors.green, size: 24),
        ],
      ),
    );
  }

  Widget _buildIndexBadge(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withAlpha(200),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: AppStyles.styleSemiBold16(
            context,
          ).copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: AppStyles.styleSemiBold14(context)),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.scale, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              '${product.quantity} ${product.unit}',
              style: AppStyles.styleMedium12(context).copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
