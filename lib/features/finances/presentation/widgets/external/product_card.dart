import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/utils/app_assets.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/models/external/external_Item_model.dart';

// ======== Model ========
class ProductItem {
  final String nameEn;
  final String nameAr;
  final double remainingWeight;
  final String imageUrl;

  const ProductItem({
    required this.nameEn,
    required this.nameAr,
    required this.remainingWeight,
    required this.imageUrl,
  });
}

// ======== Dummy Data ========
final List<ProductItem> dummyProducts = [
  const ProductItem(
    nameEn: 'Kraft Paper',
    nameAr: 'ورق كرافت معاد تدويره',
    remainingWeight: 6.2,
    imageUrl:
        'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=200',
  ),
  const ProductItem(
    nameEn: 'Grand Paper',
    nameAr: 'ورق جراند فاخر',
    remainingWeight: 4.3,
    imageUrl:
        'https://images.unsplash.com/photo-1612198273689-b4c5bf27f8a1?w=200',
  ),
];

// ======== Product Card ========
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ExternalItemModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3BC577).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image Section ──
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(kBorderRadius),
              bottomRight: Radius.circular(kBorderRadius),
            ),
            child: Image.asset(
              AppAssets.miniature,
              width: 90,
              height: 80,
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => Container(
                width: 90,
                height: 80,
                color: Colors.grey.shade100,
                child: Icon(
                  Icons.image_outlined,
                  color: Colors.grey.shade300,
                  size: 28,
                ),
              ),
            ),
          ),

          // ── Name Section ──
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Text(
                product.doshTypeName,
                textAlign: TextAlign.right,
                style: AppStyles.styleBold14(
                  context,
                ).copyWith(color: Color(0xFF1A1A1A)),
              ),
            ),
          ),

          // ── Weight Section ──
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        getWeightValue(product.quantityKg).toString(),
                        style: AppStyles.styleBold22(
                          context,
                        ).copyWith(color: Color(0xFF10B981)),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        getWeightUnit(product.quantityKg),
                        style: AppStyles.styleMedium12(
                          context,
                        ).copyWith(color: Color(0xFF10B981)),
                      ),
                    ],
                  ),
                  Text(
                    'صافي الوزن',
                    style: AppStyles.styleMedium12(
                      context,
                    ).copyWith(color: Colors.grey.shade400, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String getWeightUnit(num totalWeight) {
  return totalWeight < 1000 ? 'كجم' : 'طن';
}

num getWeightValue(num totalWeight) {
  return totalWeight < 1000 ? totalWeight : totalWeight / 1000;
}
