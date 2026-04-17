import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/models/internal/finance_shipment_model.dart';
import 'package:trader_app/features/finances/presentation/widgets/history/pagination_footer.dart';
import 'package:trader_app/features/finances/presentation/widgets/internal/shipment_Item_card.dart';

class ShipmentsListSection extends StatefulWidget {
  final List<FinanceShipmentModel> shipments;

  const ShipmentsListSection({super.key, required this.shipments});

  @override
  State<ShipmentsListSection> createState() => _ShipmentsListSectionState();
}

class _ShipmentsListSectionState extends State<ShipmentsListSection> {
  static const int _pageSize = 5;
  int _currentPage = 1;

  int get _totalPages => (widget.shipments.length / _pageSize).ceil();

  List<FinanceShipmentModel> get _currentPageItems {
    final start = (_currentPage - 1) * _pageSize;
    final end = (start + _pageSize).clamp(0, widget.shipments.length);
    return widget.shipments.sublist(start, end);
  }

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
                '${widget.shipments.length} شحنة',
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
          itemCount: _currentPageItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              ShipmentItemCard(shipment: _currentPageItems[index]),
        ),

        const SizedBox(height: 20),

        // ── Pagination ──
        if (_totalPages > 1)
          PaginationFooter(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
      ],
    );
  }
}
