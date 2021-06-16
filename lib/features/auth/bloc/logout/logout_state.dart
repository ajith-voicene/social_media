part of 'logout_cubit.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutError extends LogoutState {
  final Failure error;

  LogoutError(this.error);
  @override
  List<Object> get props => [this.error];
}
