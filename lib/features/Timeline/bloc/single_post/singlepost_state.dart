part of 'singlepost_cubit.dart';

abstract class SinglepostState extends Equatable {
  const SinglepostState();

  @override
  List<Object> get props => [];
}

class SinglepostInitial extends SinglepostState {}

class SinglepostSuccess extends SinglepostState {
  final Data post;
  final String message;

  SinglepostSuccess(this.post, this.message);
  @override
  List<Object> get props => [this.post, this.message];
}

class SinglepostError extends SinglepostState {
  final Failure error;

  SinglepostError(this.error);

  @override
  List<Object> get props => [];
}
