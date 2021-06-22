import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'chathistory_state.dart';

class ChathistoryCubit extends Cubit<ChathistoryState> {
  ChathistoryCubit() : super(ChathistoryInitial());
  final Repository repo = Repository();
  Future getMessages() async {
    emit(ChathistoryInitial());
    final result = await repo.getMessageHistory();
    result.fold((l) => emit(ChathistoryError()), (r) {
      emit(ChathistorySuccess(r));
    });
  }
}
