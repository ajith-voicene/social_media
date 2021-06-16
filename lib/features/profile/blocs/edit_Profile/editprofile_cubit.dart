import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/repository/repository.dart';

part 'editprofile_state.dart';

class EditprofileCubit extends Cubit<EditprofileState> {
  EditprofileCubit() : super(EditprofileInitial());

  final Repository repo = Repository();
  Future editProfile(File file, String name) async {
    emit(EditprofileLoading());
    final result = await repo.editProfile(
      file,
      name,
    );
    result.fold(
        (l) => emit(EditprofileError(l)), (r) => emit(EditprofileSuccess(r)));
  }
}
