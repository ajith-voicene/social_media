part of 'chathistory_cubit.dart';

abstract class ChathistoryState extends Equatable {
  const ChathistoryState();

  @override
  List<Object> get props => [];
}

class ChathistoryInitial extends ChathistoryState {}

class ChathistoryError extends ChathistoryState {}

class ChathistorySuccess extends ChathistoryState {
  final List<User> list;

  ChathistorySuccess(this.list);

  @override
  List<Object> get props => [];
}
