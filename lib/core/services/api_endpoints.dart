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

  // finances
  static const String getFinancesMethods = '/trader/me/receiving-methods';

  static const String getFinancesSummary = '/trader/me/finance/summary';

  static const String getFinancesItems = '/trader/me/finance/items';

  static const String getExternalFinanceDetails =
      '/trader/me/finance/external/shipments/{shipmentId}';

  static const String getMealFinanceDetails =
      '/trader/me/finance/meal/payments/{paymentId}';

  static const String getMonthlyFinanceDetails =
      '/trader/me/finance/monthly/payments/{paymentId}';

  static const String getFinancePaymentPdf =
      '/trader/me/finance/payments/{paymentId}/invoice/download';

  // settings
  static const String updateProfile = '/trader/settings/profile';
  static const String updateFinanceMethods =
      '/trader/settings/receiving-methods';
  static const String updateNotificationsPermissions =
      '/trader/settings/notifications';
  static const String updatePassword = '/trader/settings/password';
  static const String requestEmailChange =
      '/trader/settings/email/request-change';
  static const String confirmEmailChange =
      '/trader/settings/email/confirm-change';
  static const String updateLogo = '/trader/settings/logo';
}
