class NotificationPreferencesModel {
  final NotificationChannelModel? shipments;
  final NotificationChannelModel? finance;
  final NotificationChannelModel? system;

  NotificationPreferencesModel({this.shipments, this.finance, this.system});

  // fromJson constructor
  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) {
    return NotificationPreferencesModel(
      shipments: (json['shipments'] == null)
          ? null
          : NotificationChannelModel.fromJson(json['shipments']),
      finance: (json['finance'] == null)
          ? null
          : NotificationChannelModel.fromJson(json['finance']),
      system: (json['system'] == null)
          ? null
          : NotificationChannelModel.fromJson(json['system']),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'shipments': shipments?.toJson(),
      'finance': finance?.toJson(),
      'system': system?.toJson(),
    };
  }

  // toString method for debugging
  @override
  String toString() {
    return 'NotificationPreferencesModel(shipments: $shipments, finance: $finance, system: $system)';
  }

  // copyWith method
  NotificationPreferencesModel copyWith({
    NotificationChannelModel? shipments,
    NotificationChannelModel? finance,
    NotificationChannelModel? system,
  }) {
    return NotificationPreferencesModel(
      shipments: shipments ?? this.shipments,
      finance: finance ?? this.finance,
      system: system ?? this.system,
    );
  }
}

class NotificationChannelModel {
  final bool inApp;
  final bool push;
  final bool email;

  NotificationChannelModel({
    required this.inApp,
    required this.push,
    required this.email,
  });

  // fromJson constructor
  factory NotificationChannelModel.fromJson(Map<String, dynamic> json) {
    return NotificationChannelModel(
      inApp: json['inApp'],
      push: json['push'],
      email: json['email'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {'inApp': inApp, 'push': push, 'email': email};
  }

  // toString method for debugging
  @override
  String toString() {
    return 'NotificationChannelModel(inApp: $inApp, push: $push, email: $email)';
  }

  // copyWith method
  NotificationChannelModel copyWith({bool? inApp, bool? push, bool? email}) {
    return NotificationChannelModel(
      inApp: inApp ?? this.inApp,
      push: push ?? this.push,
      email: email ?? this.email,
    );
  }
}
