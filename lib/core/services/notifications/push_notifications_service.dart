import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:trader_app/core/services/notifications/local_notifications_service.dart';
import 'package:trader_app/core/services/storage_services.dart';

/// ✅ MUST be top-level + annotated
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class PushNotificationsService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    NotificationSettings settings = await messaging.requestPermission();

    // Get authorization status
    AuthorizationStatus authStatus = settings.authorizationStatus;
    Logger().d('Notification Authorization Status: $authStatus');

    await messaging.getToken().then(
      (token) => registerDeviceTokenWithAuthStatus(
        token: token,
        authStatus: authStatus,
      ),
    );

    messaging.onTokenRefresh.listen(
      (token) => registerDeviceTokenWithAuthStatus(
        token: token,
        authStatus: authStatus,
      ),
    );

    /// ✅ reference top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // foreground notification
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationsService.showBasicNotification(message: message);
    });
  }

  static void registerDeviceTokenWithAuthStatus({
    required String? token,
    required AuthorizationStatus authStatus,
  }) {
    // تحديد نوع المنصة
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    } else {
      platform = 'unknown';
    }

    StorageServices.storeData("fcm_token", token);
    StorageServices.storeData(
      "fcm_auth_status",
      (authStatus == AuthorizationStatus.authorized) ? "true" : "false",
    );
    StorageServices.storeData("fcm_platform", platform);

    Logger().w('''
╔════════════════════════════════════════
║ FCM Device Registration
╠════════════════════════════════════════
║ Token: $token
║ Platform: $platform
║ Authorization Status: $authStatus
╚════════════════════════════════════════
    ''');
  }
}
