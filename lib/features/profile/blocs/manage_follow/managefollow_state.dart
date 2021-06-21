part of 'managefollow_cubit.dart';

abstract class ManagefollowState extends Equatable {
  const ManagefollowState();

  @override
  List<Object> get props => [];
}

class ManagefollowInitial extends ManagefollowState {}

class ManagefollowLoading extends ManagefollowState {}

class ManagefollowError extends ManagefollowState {}

class ManagefollowSuccess extends ManagefollowState {
  final bool success;

  ManagefollowSuccess(this.success);
  @override
  List<Object> get props => [this.success];
}
