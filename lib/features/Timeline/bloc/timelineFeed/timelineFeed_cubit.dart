import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'timelineFeed_state.dart';

class TimelineFeedCubit extends Cubit<TimelineFeedState> {
  TimelineFeedCubit() : super(TimelineFeedInitial());
  final Repository repo = Repository();
  Future getPosts() async {
    emit(TimelineFeedLoading());
    final result = await repo.getPosts();
    result.fold(
        (l) => emit(TimelineFeedError(l)), (r) => emit(TimelineFeedSuccess(r)));
  }
}
