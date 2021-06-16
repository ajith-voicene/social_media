part of 'social_login_cubit.dart';

abstract class SocialLoginState extends Equatable {
  const SocialLoginState();

  @override
  List<Object> get props => [];
}

class SocialLoginInitial extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {}

class SocialLoginSuccess extends SocialLoginState {
  final bool success;

  SocialLoginSuccess(this.success);
  @override
  List<Object> get props => [this.success];
}

class SocialLoginError extends SocialLoginState {
  final Failure error;

  SocialLoginError(this.error);
  @override
  List<Object> get props => [this.error];
}
