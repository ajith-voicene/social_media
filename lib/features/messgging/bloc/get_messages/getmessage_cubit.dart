import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'getmessage_state.dart';

class GetmessageCubit extends Cubit<GetmessageState> {
  GetmessageCubit() : super(GetmessageInitial());
  final Repository repo = Repository();
  List<Message> list = [];
  Future getMessages(String userId) async {
    emit(GetmessageInitial());
    final result = await repo.getMessage(userId);
    result.fold((l) => emit(GetmessageError()), (r) {
      list = r;
      emit(GetmessageSuccess(r));
    });
  }

  Future getSoftMessages(String userId) async {
    emit(GetmessageLoading(list));
    final result = await repo.getMessage(userId);
    result.fold((l) => emit(GetmessageError()), (r) {
      list = r;
      emit(GetmessageSuccess(r));
    });
  }
}
