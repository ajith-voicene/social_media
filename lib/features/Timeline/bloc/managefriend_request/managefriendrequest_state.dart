part of 'managefriendrequest_cubit.dart';

abstract class MnageFriendrequestState extends Equatable {
  const MnageFriendrequestState();

  @override
  List<Object> get props => [];
}

class MnageFriendrequestInitial extends MnageFriendrequestState {}

class MnageFriendrequestLoading extends MnageFriendrequestState {}

class MnageFriendrequestError extends MnageFriendrequestState {
  final Failure error;

  MnageFriendrequestError(this.error);
  @override
  List<Object> get props => [this.error];
}

class MnageFriendrequestSuccess extends MnageFriendrequestState {
  final bool success;

  MnageFriendrequestSuccess(this.success);
  @override
  List<Object> get props => [this.success];
}
