class RequestEmailChangeModel {
  final String newEmail;
  final String currentPassword;

  RequestEmailChangeModel({
    required this.newEmail,
    required this.currentPassword,
  });

  factory RequestEmailChangeModel.fromJson(Map<String, dynamic> json) {
    return RequestEmailChangeModel(
      newEmail: json['newEmail'] as String,
      currentPassword: json['currentPassword'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'newEmail': newEmail, 'currentPassword': currentPassword};
  }

  @override
  String toString() {
    return 'RequestEmailChangeModel(newEmail: $newEmail, '
        'currentPassword: $currentPassword)';
  }

  RequestEmailChangeModel copyWith({
    String? newEmail,
    String? currentPassword,
  }) {
    return RequestEmailChangeModel(
      newEmail: newEmail ?? this.newEmail,
      currentPassword: currentPassword ?? this.currentPassword,
    );
  }
}
