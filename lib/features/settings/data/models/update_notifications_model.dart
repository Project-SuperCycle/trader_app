class UpdateNotificationsModel {
  final NotificationChannelsModel shipments;
  final NotificationChannelsModel finance;
  final NotificationChannelsModel system;

  UpdateNotificationsModel({
    required this.shipments,
    required this.finance,
    required this.system,
  });

  factory UpdateNotificationsModel.fromJson(Map<String, dynamic> json) {
    return UpdateNotificationsModel(
      shipments: NotificationChannelsModel.fromJson(
        json['shipments'] as Map<String, dynamic>,
      ),
      finance: NotificationChannelsModel.fromJson(
        json['finance'] as Map<String, dynamic>,
      ),
      system: NotificationChannelsModel.fromJson(
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
    NotificationChannelsModel? shipments,
    NotificationChannelsModel? finance,
    NotificationChannelsModel? system,
  }) {
    return UpdateNotificationsModel(
      shipments: shipments ?? this.shipments,
      finance: finance ?? this.finance,
      system: system ?? this.system,
    );
  }
}

// --------------------------------------------------

class NotificationChannelsModel {
  final bool inApp;
  final bool push;
  final bool email;

  NotificationChannelsModel({
    required this.inApp,
    required this.push,
    required this.email,
  });

  factory NotificationChannelsModel.fromJson(Map<String, dynamic> json) {
    return NotificationChannelsModel(
      inApp: json['inApp'] as bool,
      push: json['push'] as bool,
      email: json['email'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'inApp': inApp, 'push': push, 'email': email};
  }

  @override
  String toString() {
    return 'NotificationChannelsModel(inApp: $inApp, push: $push, email: $email)';
  }

  NotificationChannelsModel copyWith({bool? inApp, bool? push, bool? email}) {
    return NotificationChannelsModel(
      inApp: inApp ?? this.inApp,
      push: push ?? this.push,
      email: email ?? this.email,
    );
  }

  // Helper getters
  bool get hasAnyEnabled => inApp || push || email;

  bool get allEnabled => inApp && push && email;

  bool get allDisabled => !inApp && !push && !email;
}
