import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/repository/repository.dart';

part 'social_login_state.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  final Repository repo = Repository();
  SocialLoginCubit() : super(SocialLoginInitial());
  void login(String token) async {
    emit(SocialLoginLoading());
    final result = await repo.login(token);
    result.fold(
        (l) => emit(SocialLoginError(l)), (r) => emit(SocialLoginSuccess(r)));
  }
}
