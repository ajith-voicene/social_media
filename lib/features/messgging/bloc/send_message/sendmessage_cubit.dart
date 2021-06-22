import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/repository/repository.dart';

part 'sendmessage_state.dart';

class SendmessageCubit extends Cubit<SendmessageState> {
  SendmessageCubit() : super(SendmessageInitial());
  final Repository repo = Repository();
  Future editProfile(String userId, String msg) async {
    emit(SendmessageLoading());
    final result = await repo.sendMessage(msg, userId);
    result.fold(
        (l) => emit(SendmessageError()), (r) => emit(SendmessageSuccess(r)));
  }
}
