import 'package:flutter/material.dart';
import 'package:trader_app/features/sales_process/data/models/dosh_item_model.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/entry_shipment_details_cotent.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/step_header.dart';

class ProductSelectionStep extends StatelessWidget {
  final List<DoshItemModel> products;
  final Function(List<DoshItemModel>) onProductsChanged;

  const ProductSelectionStep({
    super.key,
    required this.products,
    required this.onProductsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepHeader(
          title: 'اختيار المنتجات',
          subtitle: 'اختر المنتجات التي تريد شحنها',
          icon: Icons.inventory_2_rounded,
          stepNumber: 1,
        ),
        const SizedBox(height: 24),
        EntryShipmentDetailsContent(
          products: products,
          onProductsChanged: onProductsChanged,
        ),
      ],
    );
  }
}
