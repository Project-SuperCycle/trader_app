import 'package:flutter/material.dart';
import 'package:trader_app/core/helpers/custom_confirm_dialog.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class DateTimePickerHelper {
  static Future<DateTime?> selectDateTime(
    BuildContext context, {
    DateTime? currentSelectedDateTime,
  }) async {
    // تحديد نطاق التواريخ المسموحة (من بعد يومين من اليوم الحالي فما فوق)
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime minDate = today.add(const Duration(days: 4));
    final DateTime maxDate = today.add(
      const Duration(days: 365),
    ); // حتى سنة من الآن

    // أولاً اختيار التاريخ
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentSelectedDateTime ?? minDate,
      firstDate: minDate,
      lastDate: maxDate,
      locale: const Locale('ar'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
              secondary: AppColors.primary,
              onSecondary: Colors.white,
            ),
            textTheme: TextTheme(
              headlineLarge: AppStyles.styleBold24(context),
              headlineMedium: AppStyles.styleSemiBold22(context),
              bodyLarge: AppStyles.styleMedium16(context),
              titleMedium: AppStyles.styleSemiBold18(context),
              labelLarge: AppStyles.styleSemiBold16(context),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                textStyle: AppStyles.styleBold16(context),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: AppStyles.styleSemiBold18(context),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // loop للتأكد من اختيار وقت صحيح
      while (true) {
        // إذا تم اختيار تاريخ، اعرض اختيار الوقت
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: currentSelectedDateTime != null
              ? TimeOfDay.fromDateTime(currentSelectedDateTime)
              : const TimeOfDay(hour: 12, minute: 0),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primary,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                  secondary: AppColors.primary,
                  onSecondary: Colors.white,
                ),
                textTheme: TextTheme(
                  displayLarge: AppStyles.styleBold24(context),
                  titleMedium: AppStyles.styleSemiBold18(context),
                  bodyMedium: AppStyles.styleMedium14(context),
                  labelLarge: AppStyles.styleSemiBold16(context),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    textStyle: AppStyles.styleBold16(context),
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    textStyle: AppStyles.styleBold16(context),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        // لو المستخدم ألغى اختيار الوقت
        if (pickedTime == null) {
          return null;
        }

        // ✅ التحقق من أن الوقت المختار ليس بين 10 مساءً و 12 صباحًا
        if (_isTimeRestricted(pickedTime)) {
          // عرض رسالة تنبيه للمستخدم باستخدام CustomDialog
          bool shouldRetry = false;

          await showCustomConfirmationDialog(
            context: context,
            title: 'وقت غير متاح',
            message:
                'عذراً، لا يمكن اختيار وقت من الساعة 10 مساءً حتى 12 صباحاً. الرجاء اختيار وقت آخر.',
            type: DialogType.warning,
            confirmText: 'اختر وقت آخر',
            cancelText: 'إلغاء',
            isDismissible: false,
            onConfirmed: () {
              shouldRetry = true;
            },
          );

          // لو المستخدم ضغط إلغاء
          if (!shouldRetry) {
            return null;
          }

          // لو ضغط "اختر وقت آخر"، الـ loop هيكمل ويفتح الـ time picker تاني
          continue;
        }

        // ✅ الوقت مسموح، كمل العملية
        // دمج التاريخ والوقت مع تحديد المنطقة الزمنية GMT+2
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // تحويل التاريخ والوقت إلى منطقة زمنية محددة (GMT+2)
        const Duration timeZoneOffset = Duration(hours: 2);
        final DateTime dateTimeWithTimeZone = DateTime.utc(
          combinedDateTime.year,
          combinedDateTime.month,
          combinedDateTime.day,
          combinedDateTime.hour,
          combinedDateTime.minute,
        ).add(timeZoneOffset);

        // طباعة التاريخ بالصيغة المطلوبة للتحقق
        debugPrint(
          'Selected DateTime: ${formatDateTimeWithTimeZone(dateTimeWithTimeZone, timeZoneOffset)}',
        );
        return dateTimeWithTimeZone;
      }
    }

    return null;
  }

  // ✅ دالة للتحقق من أن الوقت محظور (من 10 مساءً إلى 12 صباحًا)
  static bool _isTimeRestricted(TimeOfDay time) {
    // الوقت المحظور: من الساعة 22:00 (10 مساءً) إلى 23:59 (11:59 مساءً)
    // الساعة 22 و 23 محظورين
    final isRestricted = time.hour >= 22;
    debugPrint(
      'Checking time ${time.hour}:${time.minute} - Restricted: $isRestricted',
    );
    return isRestricted;
  }

  // دالة مساعدة لتنسيق التاريخ والوقت بصيغة ISO 8601 مع الـ timezone
  static String formatDateTimeWithTimeZone(DateTime dateTime, Duration offset) {
    // تحويل الـ offset إلى صيغة نصية (+02:00)
    final int offsetHours = offset.inHours;
    final int offsetMinutes = offset.inMinutes % 60;
    final String offsetString = offsetHours >= 0
        ? '+${offsetHours.toString().padLeft(2, '0')}:${offsetMinutes.toString().padLeft(2, '0')}'
        : '-${(-offsetHours).toString().padLeft(2, '0')}:${(-offsetMinutes).toString().padLeft(2, '0')}';

    // تنسيق التاريخ والوقت
    final String formattedDateTime =
        '${dateTime.year.toString().padLeft(4, '0')}-'
        '${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.day.toString().padLeft(2, '0')}T'
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:'
        '${dateTime.second.toString().padLeft(2, '0')}'
        '$offsetString';

    return formattedDateTime;
  }
}
