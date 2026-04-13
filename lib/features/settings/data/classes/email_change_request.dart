class EmailChangeRequest {
  final String newEmail;
  final String currentPassword;

  const EmailChangeRequest({
    required this.newEmail,
    required this.currentPassword,
  });
}
