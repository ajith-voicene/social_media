import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'friendslist_state.dart';

class FriendslistCubit extends Cubit<FriendslistState> {
  FriendslistCubit() : super(FriendslistInitial());

  final Repository repo = Repository();
  Future getfriendsList() async {
    emit(FriendslistLoading());
    final result = await repo.getfriendsList();
    return result.fold(
        (l) => emit(FriendslistError(l)), (r) => emit(FriendslistSuccess(r)));
  }
}
