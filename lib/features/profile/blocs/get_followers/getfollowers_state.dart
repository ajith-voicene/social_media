part of 'getfollowers_cubit.dart';

abstract class GetfollowersState extends Equatable {
  const GetfollowersState();

  @override
  List<Object> get props => [];
}

class GetfollowersInitial extends GetfollowersState {}

class GetfollowersSuccess extends GetfollowersState {
  final List<User> list;

  GetfollowersSuccess(this.list);
  @override
  List<Object> get props => [this.list];
}

class GetfollowersError extends GetfollowersState {
  final Failure error;

  GetfollowersError(this.error);
  @override
  List<Object> get props => [this.error];
}
