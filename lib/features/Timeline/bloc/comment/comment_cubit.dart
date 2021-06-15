import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());
  List<Comment> list = [];
  final Repository repo = Repository();
  Future getComments(int postId) async {
    emit(CommentInitial());
    final result = await repo.getComments("$postId");
    result.fold((l) => emit(CommentError(l)), (r) {
      list = r;
      emit(CommentSuccess(r));
    });
  }

  Future addComment(int postId, String content) async {
    emit(CommentLoading(list));
    final result = await repo.addComment("$postId", content);
    result.fold((l) => emit(CommentError(l)), (r) {
      emit(CommentCreateSuccess(r));
      emit(CommentSuccess(list));
    });
  }
}
