import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/repository/repository.dart';

part 'createPost_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostInitial());
  final Repository repo = Repository();
  Future createPost(File file, bool isVideo, String text) async {
    emit(CreatePostLoading());
    final result = await repo.createPost(file, text);
    result.fold(
        (l) => emit(CreatePostError(l)), (r) => emit(CreatePostSuccess(r)));
  }
}
