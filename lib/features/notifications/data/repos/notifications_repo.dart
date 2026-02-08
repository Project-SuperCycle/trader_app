import 'package:dartz/dartz.dart';
import 'package:trader_app/core/errors/failures.dart' show Failure;
import 'package:trader_app/core/models/notifications_model.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, List<NotificationModel>>> fetchNotifications();

  Future<Either<Failure, String>> readNotification({
    required String notificationId,
  });

  Future<Either<Failure, String>> deleteNotification({
    required String notificationId,
  });
}
