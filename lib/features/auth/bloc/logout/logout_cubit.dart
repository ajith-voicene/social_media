import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/repository/repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final Repository repo = Repository();
  LogoutCubit() : super(LogoutInitial());
  Future logout() async {
    emit(LogoutLoading());
    final result = await repo.logout();
    result.fold((l) => emit(LogoutError(l)), (r) => emit(LogoutSuccess()));
  }
}
