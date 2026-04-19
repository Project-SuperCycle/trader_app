import 'package:trader_app/features/sign_in/data/models/notification_preferences_model.dart';

class UpdateNotificationsModel {
  final NotificationChannelModel shipments;
  final NotificationChannelModel finance;
  final NotificationChannelModel system;

  UpdateNotificationsModel({
    required this.shipments,
    required this.finance,
    required this.system,
  });

  factory UpdateNotificationsModel.fromJson(Map<String, dynamic> json) {
    return UpdateNotificationsModel(
      shipments: NotificationChannelModel.fromJson(
        json['shipments'] as Map<String, dynamic>,
      ),
      finance: NotificationChannelModel.fromJson(
        json['finance'] as Map<String, dynamic>,
      ),
      system: NotificationChannelModel.fromJson(
        json['system'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipments': shipments.toJson(),
      'finance': finance.toJson(),
      'system': system.toJson(),
    };
  }

  @override
  String toString() {
    return 'UpdateNotificationsModel(shipments: $shipments, '
        'finance: $finance, system: $system)';
  }

  UpdateNotificationsModel copyWith({
    NotificationChannelModel? shipments,
    NotificationChannelModel? finance,
    NotificationChannelModel? system,
  }) {
    return UpdateNotificationsModel(
      shipments: shipments ?? this.shipments,
      finance: finance ?? this.finance,
      system: system ?? this.system,
    );
  }
}
