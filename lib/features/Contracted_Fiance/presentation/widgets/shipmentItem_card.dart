import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';

// ======== Model ========
class ShipmentItem {
  final String shipmentNumber;
  final String date;
  final double totalWeight;
  final double value;
  final String paymentMethod;

  const ShipmentItem({
    required this.shipmentNumber,
    required this.date,
    required this.totalWeight,
    required this.value,
    required this.paymentMethod,
  });
}

// ======== Dummy Data ========
final List<ShipmentItem> dummyShipments = [
  const ShipmentItem(
    shipmentNumber: 'SC-88210',
    date: '15 يونيو 2024',
    totalWeight: 4.5,
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

// ======== Shipment Card ========
class ShipmentItemCard extends StatelessWidget {
  const ShipmentItemCard({
    super.key,
    required this.shipment,
    required this.onDetailsTap,
  });

  final ShipmentItem shipment;
  final VoidCallback onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Row 1: Shipment Number + Date ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shipment Number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رقم الشحنة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shipment.shipmentNumber,
                      style: const TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),

                // Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تاريخ الوزن',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shipment.date,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ── Row 2: Weight + Value ──
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Weight
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.inventory_2_outlined,
                                  color: Colors.grey.shade600,
                                  size: 16,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'الوزن الكلي',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Row(
                                    children: [
                                      Text(
                                        '${shipment.totalWeight}',
                                        style: const TextStyle(
                                          color: Color(0xFF1A1A1A),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        'طن',
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),


                    ],
                  ),

                  // Value
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.attach_money_rounded,
                          color: Colors.grey.shade600,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'القيمة',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                shipment.value
                                    .toStringAsFixed(0)
                                    .replaceAllMapped(
                                  RegExp(r'\B(?=(\d{3})+(?!\d))'),
                                      (m) => ',',
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'ج.م',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ── Row 3: Payment Method + Details ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Payment Method
                Text(
                  'طريقة التحصيل: ${shipment.paymentMethod}',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                ),

                // Details Button
                GestureDetector(
                  onTap: onDetailsTap,
                  child: Row(
                    children: [
                      const Text(
                        'التفاصيل',
                        style: TextStyle(
                          color: Color(0xFF3BC577),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF3BC577),
                        size: 16,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
