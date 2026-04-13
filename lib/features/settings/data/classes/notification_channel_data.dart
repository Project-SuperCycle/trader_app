class NotificationChannelData {
  bool inApp;
  bool local;
  bool email;

  NotificationChannelData({
    this.inApp = false,
    this.local = false,
    this.email = false,
  });

  NotificationChannelData copyWith({bool? inApp, bool? local, bool? email}) =>
      NotificationChannelData(
        inApp: inApp ?? this.inApp,
        local: local ?? this.local,
        email: email ?? this.email,
      );
}
