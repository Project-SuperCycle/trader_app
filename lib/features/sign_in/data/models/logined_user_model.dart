import 'package:trader_app/features/sign_in/data/models/notification_preferences_model.dart';

class LoginUserModel {
  final String? bussinessName;
  final String? rawBusinessType;
  final String? bussinessAdress;
  final String? doshMangerName;
  final String? doshMangerPhone;
  final String? email;
  final String? role;
  final String? phone;
  final String? displayName;
  final bool? isEcoParticipant;

  final String? settlementType;

  final String? logoUrl;

  final NotificationPreferencesModel notificationPreferences;

  LoginUserModel({
    this.bussinessName,
    this.rawBusinessType,
    this.bussinessAdress,
    this.doshMangerName,
    this.doshMangerPhone,
    this.email,
    this.role,
    this.phone,
    this.displayName,
    this.isEcoParticipant,
    this.settlementType,
    this.logoUrl,
    required this.notificationPreferences,
  });

  // fromJson constructor
  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      bussinessName: (json['profile'] == null)
          ? null
          : json['profile']['bussinessName'],
      rawBusinessType: (json['profile'] == null)
          ? null
          : json['profile']['rawBusinessType'],
      bussinessAdress: (json['profile'] == null)
          ? null
          : json['profile']['bussinessAdress'],
      doshMangerName: (json['profile'] == null)
          ? null
          : json['profile']['doshMangerName'],
      doshMangerPhone: (json['profile'] == null)
          ? null
          : json['profile']['doshMangerPhone'],
      email: json['email'],
      role: json['role'],
      phone: json['phone'],
      displayName: json['displayName'],
      isEcoParticipant: json['isEcoParticipant'],
      settlementType: json['settlementType'],
      logoUrl: json['logoUrl'],
      notificationPreferences: NotificationPreferencesModel.fromJson(
        json['notificationPreferences'],
      ),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'bussinessName': bussinessName,
      'rawBusinessType': rawBusinessType,
      'bussinessAdress': bussinessAdress,
      'doshMangerName': doshMangerName,
      'doshMangerPhone': doshMangerPhone,
      'email': email,
      'role': role,
      'phone': phone,
      'displayName': displayName,
      'isEcoParticipant': isEcoParticipant,
      'settlementType': settlementType,
      'logoUrl': logoUrl,
      'notificationPreferences': notificationPreferences.toJson(),
    };
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'LoginedUserModel(bussinessName: $bussinessName, rawBusinessType: $rawBusinessType, bussinessAdress: $bussinessAdress, doshMangerName: $doshMangerName, doshMangerPhone: $doshMangerPhone, email: $email, role: $role, phone: $phone, displayName: $displayName, isEcoParticipant: $isEcoParticipant, settlementType: $settlementType)';
  }

  // Optional: copyWith method for creating modified copies
  LoginUserModel copyWith({
    String? bussinessName,
    String? rawBusinessType,
    String? bussinessAdress,
    String? doshMangerName,
    String? doshMangerPhone,
    String? email,
    String? role,
    String? phone,
    String? displayName,
    bool? isEcoParticipant,
    String? settlementType,
    String? logoUrl,
    NotificationPreferencesModel? notificationPreferences,
  }) {
    return LoginUserModel(
      bussinessName: bussinessName ?? this.bussinessName,
      rawBusinessType: rawBusinessType ?? this.rawBusinessType,
      bussinessAdress: bussinessAdress ?? this.bussinessAdress,
      doshMangerName: doshMangerName ?? this.doshMangerName,
      doshMangerPhone: doshMangerPhone ?? this.doshMangerPhone,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      displayName: displayName ?? this.displayName,
      isEcoParticipant: isEcoParticipant ?? this.isEcoParticipant,
      settlementType: settlementType ?? this.settlementType,
      logoUrl: logoUrl ?? this.logoUrl,
      notificationPreferences:
          notificationPreferences ?? this.notificationPreferences,
    );
  }
}
