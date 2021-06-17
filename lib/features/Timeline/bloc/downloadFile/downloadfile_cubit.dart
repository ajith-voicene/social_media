import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/repository/repository.dart';

part 'downloadfile_state.dart';

class DownloadfileCubit extends Cubit<DownloadfileState> {
  DownloadfileCubit() : super(DownloadfileInitial());
  final Repository repo = Repository();
  Future getFile(String url, String postid, String ext) async {
    emit(DownloadfileInitial());
    final result = await repo.downloadFile(url, postid, ext);
    result.fold(
        (l) => emit(DownloadfileError(l)), (r) => emit(DownloadfileSuccess(r)));
  }
}
