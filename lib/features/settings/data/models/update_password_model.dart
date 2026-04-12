class UpdatePasswordModel {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  UpdatePasswordModel({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordModel(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
      confirmNewPassword: json['confirmNewPassword'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }

  @override
  String toString() {
    return 'UpdatePasswordModel(currentPassword: $currentPassword, '
        'newPassword: $newPassword, confirmNewPassword: $confirmNewPassword)';
  }

  UpdatePasswordModel copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) {
    return UpdatePasswordModel(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
    );
  }

  // Helper getters
  bool get passwordsMatch => newPassword == confirmNewPassword;

  bool get isNewPasswordDifferent => currentPassword != newPassword;
}
