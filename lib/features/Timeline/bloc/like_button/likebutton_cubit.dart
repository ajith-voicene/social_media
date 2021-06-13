import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/repository/repository.dart';

part 'likebutton_state.dart';

class LikebuttonCubit extends Cubit<LikebuttonState> {
  LikebuttonCubit() : super(LikebuttonInitial());

  final Repository repo = Repository();
  Future onLiked(int like, String postId) async {
    emit(LikebuttonInitial());
    final result = await repo.onLiked(like, postId);
    result.fold(
        (l) => emit(LikebuttonError(l)), (r) => emit(LikebuttonSuccess(r)));
  }
}
