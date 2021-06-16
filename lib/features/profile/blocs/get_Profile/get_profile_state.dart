part of 'get_profile_cubit.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

class GetProfileInitial extends GetProfileState {}

class GetProfileSuccess extends GetProfileState {
  final User user;

  GetProfileSuccess(this.user);
  @override
  List<Object> get props => [this.user];
}

class GetProfileError extends GetProfileState {
  final Failure error;

  GetProfileError(this.error);
  @override
  List<Object> get props => [this.error];
}
