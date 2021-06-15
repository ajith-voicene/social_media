part of 'comment_cubit.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {
  final List<Comment> list;

  CommentLoading(this.list);
  @override
  List<Object> get props => [this.list];
}

class CommentError extends CommentState {
  final Failure error;

  CommentError(this.error);

  @override
  List<Object> get props => [this.error];
}

class CommentSuccess extends CommentState {
  final List<Comment> list;
  CommentSuccess(this.list);

  @override
  List<Object> get props => [this.list];
}

class CommentCreateSuccess extends CommentState {
  final String msg;
  CommentCreateSuccess(this.msg);

  @override
  List<Object> get props => [this.msg];
}
