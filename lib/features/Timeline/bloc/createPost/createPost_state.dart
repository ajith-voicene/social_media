part of 'createPost_cubit.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {
  final bool success;

  CreatePostSuccess(this.success);
  @override
  List<Object> get props => [this.success];
}

class CreatePostError extends CreatePostState {
  final Failure error;

  CreatePostError(this.error);
  @override
  List<Object> get props => [this.error];
}
