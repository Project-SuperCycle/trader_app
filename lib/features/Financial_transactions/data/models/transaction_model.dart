class TransactionModel {
  final String id;
  final String date;
  final bool isPending;
  final double totalWeight;
  final String paymentMethod;
  final String paymentMethodIcon;
  final double totalAmount;

  const TransactionModel({
    required this.id,
    required this.date,
    required this.isPending,
    required this.totalWeight,
    required this.paymentMethod,
    required this.paymentMethodIcon,
    required this.totalAmount,
  });
}
