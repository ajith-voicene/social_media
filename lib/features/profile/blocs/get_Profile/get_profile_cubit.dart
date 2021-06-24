import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(GetProfileInitial());
  final Repository repo = Repository();
  Future getProfile(String id) async {
    // emit(GetProfileInitial());
    final result = await repo.getProfile(
      id,
    );
    return result.fold(
        (l) => emit(GetProfileError(l)), (r) => emit(GetProfileSuccess(r)));
  }
}
