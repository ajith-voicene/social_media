part of 'getmessage_cubit.dart';

abstract class GetmessageState extends Equatable {
  const GetmessageState();

  @override
  List<Object> get props => [];
}

class GetmessageInitial extends GetmessageState {}

class GetmessageLoading extends GetmessageState {
  final List<Message> data;

  GetmessageLoading(this.data);
  @override
  List<Object> get props => [this.data];
}

class GetmessageSuccess extends GetmessageState {
  final List<Message> data;

  GetmessageSuccess(this.data);
  @override
  List<Object> get props => [this.data];
}

class GetmessageError extends GetmessageState {}
