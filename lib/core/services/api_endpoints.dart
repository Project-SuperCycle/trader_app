abstract class ApiEndpoints {
  static const String login = '/auth/login';
  static const String socialLogin = '/auth/social-login';
  static const String signup = '/auth/signup';
  static const String verifyOtp = '/auth/verify-otp';
  static const String completeSignup = '/auth/complete-profile';
  static const String doshPricesCurrent = '/dosh/prices/current';
  static const String doshPricesHistory = '/dosh/prices/history';
  static const String doshTypesData = '/dosh/types';
  static const String getAllShipments = '/shipments';
  static const String getShipmentsHistory = '/shipments/history';
  static const String getShipmentById = '/shipments/{id}';
  static const String createShipment = '/shipments';
  static const String editShipment = '/shipments/{id}';
  static const String cancelShipment = '/shipments/{id}/cancel';
  static const String addNotes = '/shipments/{id}/notes';
  static const String getAllNotes = '/shipments/{id}/notes';
  static const String getProfileInfo = '/trader/me';
  static const String contactUs = '/contact';
  static const String getTraderEcoInfo = '/trader/eco/dashboard';
  static const String getTraderEcoRequests = '/trader/eco/redeem';
  static const String createTraderEcoRequest = '/trader/eco/redeem';
  static const String forgetPassword = '/auth/forgot-password';
  static const String verifyResetOtp = '/auth/verify-reset-otp';
  static const String resetPassword = '/auth/reset-password';

  // notifications
  static const String registerDevice = '/auth/device-token';
  static const String getNotifications = '/notifications';
  static const String deleteNotification = '/notifications/{id}';
  static const String readNotification = '/notifications/{id}/seen';
}
