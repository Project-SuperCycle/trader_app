part of 'update_profile_cubit.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdateProfileLoading extends UpdateProfileState {}

final class UpdateProfileSuccess extends UpdateProfileState {
  final String message;

  UpdateProfileSuccess({required this.message});
}

final class UpdateProfileFailure extends UpdateProfileState {
  final String errMessage;

  UpdateProfileFailure({required this.errMessage});
}
