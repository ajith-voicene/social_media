import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/repository/repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final Repository repo = Repository();
  Future searchUsers(String name) async {
    emit(SearchLoading());
    final result = await repo.searchUsers(name);
    result.fold((l) => emit(SearchError(l)), (r) => emit(SearchSuccess(r)));
  }
}
