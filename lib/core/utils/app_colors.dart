import 'dart:ui';

abstract class AppColors {
  static const Color primary = Color(0xff194C3B);
  static const Color secondaryColor = Color(0xffCACACA);
  static const Color greenColor = Color(0xff078531);

  static const Color backgroundColor = Color(0xffFFFFFF);
  static const Color cardBackground = Color(0xffF9F5F5);

  static const Color buttonColor = Color(0xff4DB7F2);

  static const Color mainTextColor = Color(0xff1f1f1f);
  static const Color subTextColor = Color(0xff969696);

  static Color successColor = primary.withValues(alpha: 0.9);
  static const Color warningColor = Color(0xffFF9F04);
  static const Color failureColor = Color(0xffC70B0B);
}
