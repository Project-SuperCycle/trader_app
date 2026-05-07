import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/models/external/external_Item_model.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/product_card.dart';

class ProductsListSection extends StatelessWidget {
  const ProductsListSection({super.key, required this.products});

  final List<ExternalItemModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Section Header ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Text(
                'قائمة المنتجات',
                textDirection: TextDirection.rtl,
                style: AppStyles.styleBold18(
                  context,
                ).copyWith(color: Colors.white),
              ),
              Text(
                '${products.length} صنف',
                style: AppStyles.styleSemiBold16(
                  context,
                ).copyWith(color: Colors.white.withValues(alpha: 0.8)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ── Cards ──
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) =>
              ProductCard(product: products[index]),
        ),
      ],
    );
  }
}
