import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/Contracted_Fiance/presentation/widgets/shipment_Item_card.dart';
import 'package:trader_app/features/finances/presentation/widgets/history/pagination_footer.dart';

class ShipmentsListSection extends StatefulWidget {
  const ShipmentsListSection({super.key});

  @override
  State<ShipmentsListSection> createState() => _ShipmentsListSectionState();
}

class _ShipmentsListSectionState extends State<ShipmentsListSection> {
  int _currentPage = 1;
  final int _totalPages = 3;

  // ======== Dummy Data ========
  final List<ShipmentItem> dummyShipments = [
    const ShipmentItem(
      shipmentNumber: 'SC-88215',
      date: '15 يونيو 2024',
      totalWeight: 5250,
      value: 12400,
      paymentMethod: 'نقداً',
    ),
    const ShipmentItem(
      shipmentNumber: 'SC-88215',
      date: '18 يونيو 2024',
      totalWeight: 3.2,
      value: 8900,
      paymentMethod: 'نقداً',
    ),
    const ShipmentItem(
      shipmentNumber: 'SC-88220',
      date: '20 يونيو 2024',
      totalWeight: 6.1,
      value: 15300,
      paymentMethod: 'بنكي',
    ),
  ];

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
              Text(
                'الشحنات المتضمنة',
                textDirection: TextDirection.rtl,
                style: AppStyles.styleBold18(
                  context,
                ).copyWith(color: Colors.white),
              ),
              Text(
                '${dummyShipments.length} شحنة',
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
          itemCount: dummyShipments.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              ShipmentItemCard(
                shipment: dummyShipments[index],
                onDetailsTap: () {},
              ),
        ),

        const SizedBox(height: 20),

        // ── Pagination ──
        PaginationFooter(
          currentPage: _currentPage,
          totalPages: _totalPages,
          onPageChanged: (page) => setState(() => _currentPage = page),
        ),
      ],
    );
  }
}
