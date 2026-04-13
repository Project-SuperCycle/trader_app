import 'paid_summary_model.dart';
import 'pending_summary_model.dart';

class FinanceSummaryModel {
  final String settlementType;
  final String viewType;
  final PendingSummaryModel pending;
  final PaidSummaryModel paid;
  final String primarySettlementType;
  final List<String> availableTypes;
  final String requestedType;

  FinanceSummaryModel({
    required this.settlementType,
    required this.viewType,
    required this.pending,
    required this.paid,
    required this.primarySettlementType,
    required this.availableTypes,
    required this.requestedType,
  });

  factory FinanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return FinanceSummaryModel(
      settlementType: json['settlementType'] as String,
      viewType: json['viewType'] as String,
      pending: PendingSummaryModel.fromJson(
        json['pending'] as Map<String, dynamic>,
      ),
      paid: PaidSummaryModel.fromJson(json['paid'] as Map<String, dynamic>),
      primarySettlementType: json['primarySettlementType'] as String,
      availableTypes: List<String>.from(json['availableTypes']),
      requestedType: json['requestedType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'settlementType': settlementType,
      'viewType': viewType,
      'pending': pending.toJson(),
      'paid': paid.toJson(),
      'primarySettlementType': primarySettlementType,
      'availableTypes': availableTypes,
      'requestedType': requestedType,
    };
  }

  @override
  String toString() {
    return 'FinanceSummaryModel(settlementType: $settlementType, viewType: $viewType, '
        'pending: $pending, paid: $paid, primarySettlementType: $primarySettlementType, '
        'availableTypes: $availableTypes, requestedType: $requestedType)';
  }

  FinanceSummaryModel copyWith({
    String? settlementType,
    String? viewType,
    PendingSummaryModel? pending,
    PaidSummaryModel? paid,
    String? primarySettlementType,
    List<String>? availableTypes,
    String? requestedType,
  }) {
    return FinanceSummaryModel(
      settlementType: settlementType ?? this.settlementType,
      viewType: viewType ?? this.viewType,
      pending: pending ?? this.pending,
      paid: paid ?? this.paid,
      primarySettlementType:
          primarySettlementType ?? this.primarySettlementType,
      availableTypes: availableTypes ?? this.availableTypes,
      requestedType: requestedType ?? this.requestedType,
    );
  }
}
