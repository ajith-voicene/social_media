import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'getfollowers_state.dart';

class GetfollowersCubit extends Cubit<GetfollowersState> {
  GetfollowersCubit() : super(GetfollowersInitial());
  final Repository repo = Repository();
  Future getFollowingsList() async {
    emit(GetfollowersInitial());
    final result = await repo.getFollowersList();
    return result.fold(
        (l) => emit(GetfollowersError(l)), (r) => emit(GetfollowersSuccess(r)));
  }
}
