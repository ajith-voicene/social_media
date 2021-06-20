import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/repository/repository.dart';

part 'managefriendrequest_state.dart';

class MnageFriendrequestCubit extends Cubit<MnageFriendrequestState> {
  MnageFriendrequestCubit() : super(MnageFriendrequestInitial());
  final Repository repo = Repository();
  Future manageFriendrequest(String type, String userID) async {
    emit(MnageFriendrequestLoading());
    final result = await repo.manageFriendrequest(type, userID);
    result.fold((l) => emit(MnageFriendrequestError(l)),
        (r) => emit(MnageFriendrequestSuccess(r)));
  }
}
