import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/repository/repository.dart';

part 'managefollow_state.dart';

class ManagefollowCubit extends Cubit<ManagefollowState> {
  ManagefollowCubit() : super(ManagefollowInitial());
  final Repository repo = Repository();
  Future manageFollow(String type, String id) async {
    emit(ManagefollowLoading());
    final result = await repo.manageFollow(type, id);
    return result.fold(
        (l) => emit(ManagefollowError()), (r) => emit(ManagefollowSuccess(r)));
  }
}
