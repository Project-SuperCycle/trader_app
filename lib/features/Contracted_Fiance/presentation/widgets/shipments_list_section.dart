import 'package:flutter/material.dart';
import 'package:trader_app/features/Contracted_Fiance/presentation/widgets/shipmentItem_card.dart';
import 'package:trader_app/features/Financial_transactions/presentation/widgets/pagination_footer.dart';

class ShipmentsListSection extends StatefulWidget {
  const ShipmentsListSection({super.key});

  @override
  State<ShipmentsListSection> createState() => _ShipmentsListSectionState();
}

class _ShipmentsListSectionState extends State<ShipmentsListSection> {
  int _currentPage = 1;
  final int _totalPages = 3;

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
              const Text(
                'قائمة الشحنات المتضمنة',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${dummyShipments.length} شحنة',
                style: TextStyle(
                  color: Colors.green.withOpacity(0.8),
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
          itemCount: dummyShipments.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) => ShipmentItemCard(
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