part of 'getfollowings_cubit.dart';

abstract class GetfollowingsState extends Equatable {
  const GetfollowingsState();

  @override
  List<Object> get props => [];
}


class GetfollowingsInitial extends GetfollowingsState {}

class GetfollowingsSuccess extends GetfollowingsState {
  final List<User> list;

  GetfollowingsSuccess(this.list);
  @override
  List<Object> get props => [this.list];
}

class GetfollowingsError extends GetfollowingsState {
  final Failure error;

  GetfollowingsError(this.error);
  @override
  List<Object> get props => [this.error];
}
