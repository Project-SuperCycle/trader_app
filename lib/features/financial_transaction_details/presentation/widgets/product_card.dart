import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';

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
    imageUrl: 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=200',
  ),
  const ProductItem(
    nameEn: 'Grand Paper',
    nameAr: 'ورق جراند فاخر',
    remainingWeight: 4.3,
    imageUrl: 'https://images.unsplash.com/photo-1612198273689-b4c5bf27f8a1?w=200',
  ),
];

// ======== Product Card ========
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3BC577).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Image Section ──
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(kBorderRadius),
              bottomRight: Radius.circular(kBorderRadius),
            ),
            child: Image.network(
              product.imageUrl,
              width: 90,
              height: 80,
              fit: BoxFit.cover,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.nameEn,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.nameAr,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Weight Section ──
          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${product.remainingWeight}',
                      style: const TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Text(
                        'طن',
                        style: TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'الوزن المتبقي',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

// ======== Products List Section ========
class ProductsListSection extends StatelessWidget {
  const ProductsListSection({
    super.key,
    required this.products,
  });

  final List<ProductItem> products;

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
              const Text(
                'قائمة المنتجات',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${products.length} صنف',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
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