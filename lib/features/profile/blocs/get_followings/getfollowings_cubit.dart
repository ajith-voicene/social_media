import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'getfollowings_state.dart';

class GetfollowingsCubit extends Cubit<GetfollowingsState> {
  GetfollowingsCubit() : super(GetfollowingsInitial());
  final Repository repo = Repository();
  Future getFollowingsList() async {
    emit(GetfollowingsInitial());
    final result = await repo.getFollowingsList();
    return result.fold((l) => emit(GetfollowingsError(l)),
        (r) => emit(GetfollowingsSuccess(r)));
  }
}
