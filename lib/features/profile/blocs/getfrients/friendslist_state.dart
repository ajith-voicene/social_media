part of 'friendslist_cubit.dart';

abstract class FriendslistState extends Equatable {
  const FriendslistState();

  @override
  List<Object> get props => [];
}

class FriendslistInitial extends FriendslistState {}

class FriendslistLoading extends FriendslistState {}

class FriendslistError extends FriendslistState {
  final Failure error;

  FriendslistError(this.error);
  @override
  List<Object> get props => [this.error];
}

class FriendslistSuccess extends FriendslistState {
  final List<User> list;

  FriendslistSuccess(this.list);
  @override
  List<Object> get props => [this.list];
}
