part of 'trader_profile_cubit.dart';

abstract class TraderProfileState {}

class TraderProfileInitial extends TraderProfileState {}

class TraderProfileLoading extends TraderProfileState {}

class TraderProfileSavingPayment extends TraderProfileState {}

class TraderProfileLoaded extends TraderProfileState {
  final UserProfileModel profile;
  TraderProfileLoaded({required this.profile});
}

class TraderProfileError extends TraderProfileState {
  final String message;
  TraderProfileError(this.message);
}