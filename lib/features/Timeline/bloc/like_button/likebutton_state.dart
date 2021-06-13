part of 'likebutton_cubit.dart';

abstract class LikebuttonState extends Equatable {
  const LikebuttonState();

  @override
  List<Object> get props => [];
}

class LikebuttonInitial extends LikebuttonState {}

class LikebuttonError extends LikebuttonState {
  final Failure error;

  LikebuttonError(this.error);

  @override
  List<Object> get props => [this.error];
}

class LikebuttonSuccess extends LikebuttonState {
  final String msg;

  LikebuttonSuccess(this.msg);

  @override
  List<Object> get props => [this.msg];
}
