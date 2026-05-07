part of 'update_logo_cubit.dart';

@immutable
sealed class UpdateLogoState {}

final class UpdateLogoInitial extends UpdateLogoState {}

final class UpdateLogoLoading extends UpdateLogoState {}

final class UpdateLogoSuccess extends UpdateLogoState {
  final String imageUrl;

  UpdateLogoSuccess({required this.imageUrl});
}

final class UpdateLogoFailure extends UpdateLogoState {
  final String errMessage;

  UpdateLogoFailure({required this.errMessage});
}
