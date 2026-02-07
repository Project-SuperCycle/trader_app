import 'package:trader_app/features/environment/data/models/top_participant_model.dart';
import 'package:trader_app/features/environment/data/models/trader_eco_stats_model.dart';
import 'package:trader_app/features/environment/data/models/trader_transaction_model.dart';

class TraderEcoInfoModel {
  final TraderEcoStatsModel? stats;
  final List<TopParticipant>? topParticipants;
  final List<TraderTransactionModel>? transactions;
  final bool isEcoParticiapant;

  TraderEcoInfoModel({
    required this.stats,
    required this.topParticipants,
    required this.transactions,
    required this.isEcoParticiapant,
  });

  factory TraderEcoInfoModel.fromJson(Map<String, dynamic> json) {
    return TraderEcoInfoModel(
      stats: TraderEcoStatsModel.fromJson(json['stats'] ?? {}),
      topParticipants:
          (json['topParticipants'] as List?)
              ?.map((item) => TopParticipant.fromJson(item))
              .toList() ??
          [],
      transactions:
          (json['transactions'] as List?)
              ?.map((item) => TraderTransactionModel.fromJson(item))
              .toList() ??
          [],
      isEcoParticiapant: (json['isEcoParticipant'] == null)
          ? (json['user']['isEcoParticipant'] != null)
                ? json['user']['isEcoParticipant']
                : false
          : json['isEcoParticipant'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stats': (stats != null) ? stats!.toJson() : null,
      'topParticipants': (topParticipants != null)
          ? topParticipants!.map((item) => item.toJson()).toList()
          : null,
      'transactions': (transactions != null)
          ? transactions!.map((item) => item.toJson()).toList()
          : null,
      'isEcoParticiapant': isEcoParticiapant,
    };
  }
}
