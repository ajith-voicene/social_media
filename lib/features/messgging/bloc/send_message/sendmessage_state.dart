part of 'sendmessage_cubit.dart';

abstract class SendmessageState extends Equatable {
  const SendmessageState();

  @override
  List<Object> get props => [];
}

class SendmessageInitial extends SendmessageState {}

class SendmessageLoading extends SendmessageState {}

class SendmessageError extends SendmessageState {}

class SendmessageSuccess extends SendmessageState {
  final bool success;

  SendmessageSuccess(this.success);
  @override
  List<Object> get props => [this.success];
}
