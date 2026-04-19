import 'package:flutter/material.dart';

enum PaymentMethodType { cash, eWallet, bankTransfer }

class PaymentMethodOption {
  final PaymentMethodType type;
  final String label;
  final String subtitle;
  final IconData icon;

  const PaymentMethodOption({
    required this.type,
    required this.label,
    required this.subtitle,
    required this.icon,
  });
}
