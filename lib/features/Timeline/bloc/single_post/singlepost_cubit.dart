import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'singlepost_state.dart';

class SinglepostCubit extends Cubit<SinglepostState> {
  SinglepostCubit() : super(SinglepostInitial());

  final Repository repo = Repository();
  Future getSinglePost(String id) async {
    emit(SinglepostInitial());
    final result = await repo.getSinglePost(id);
    result.fold((l) => emit(SinglepostError(l)),
        (r) => emit(SinglepostSuccess(r.data1, r.data2)));
  }
}
