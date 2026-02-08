import 'package:equatable/equatable.dart';

sealed class ReadNotificationState extends Equatable {
  const ReadNotificationState();
}

final class ReadNotificationInitial extends ReadNotificationState {
  @override
  List<Object> get props => [];
}

// GET ALL SHIPMENTS
final class ReadNotificationLoading extends ReadNotificationState {
  @override
  List<Object> get props => [];
}

final class ReadNotificationSuccess extends ReadNotificationState {
  final String message;

  const ReadNotificationSuccess({required this.message});

  @override
  List<Object> get props => [];
}

final class ReadNotificationFailure extends ReadNotificationState {
  final String errorMessage;

  const ReadNotificationFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}
