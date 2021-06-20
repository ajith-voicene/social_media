part of 'friendrequests_cubit.dart';

abstract class FriendrequestsState extends Equatable {
  const FriendrequestsState();

  @override
  List<Object> get props => [];
}

class FriendrequestsInitial extends FriendrequestsState {}

class FriendrequestsLoading extends FriendrequestsState {}

class FriendrequestsError extends FriendrequestsState {
  final Failure error;

  FriendrequestsError(this.error);

  @override
  List<Object> get props => [this.error];
}

class FriendrequestsSuccess extends FriendrequestsState {
  final List<User> list;

  FriendrequestsSuccess(this.list);

  @override
  List<Object> get props => [this.list];
}
