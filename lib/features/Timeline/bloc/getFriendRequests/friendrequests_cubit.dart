import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/doubleResult.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/repository/repository.dart';

part 'friendrequests_state.dart';

class FriendrequestsCubit extends Cubit<FriendrequestsState> {
  FriendrequestsCubit() : super(FriendrequestsInitial());
  final Repository repo = Repository();
  Future getFriendrequests() async {
    emit(FriendrequestsLoading());
    final result = await repo.getFriendrequests();
    result.fold((l) => emit(FriendrequestsError(l)),
        (r) => emit(FriendrequestsSuccess(r)));
  }
}
