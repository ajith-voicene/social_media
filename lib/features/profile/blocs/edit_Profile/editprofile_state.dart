part of 'editprofile_cubit.dart';

abstract class EditprofileState extends Equatable {
  const EditprofileState();

  @override
  List<Object> get props => [];
}

class EditprofileInitial extends EditprofileState {}

class EditprofileLoading extends EditprofileState {}

class EditprofileSuccess extends EditprofileState {
  final String msg;

  EditprofileSuccess(this.msg);
  @override
  List<Object> get props => [this.msg];
}

class EditprofileError extends EditprofileState {
  final Failure error;

  EditprofileError(this.error);
  @override
  List<Object> get props => [this.error];
}
