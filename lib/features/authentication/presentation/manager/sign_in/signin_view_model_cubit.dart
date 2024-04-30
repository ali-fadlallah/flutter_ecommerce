import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/features/authentication/presentation/manager/sign_in/signin_view_model_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/local/shared_preference_helper.dart';
import '../../../domain/use_cases/signin_auth_use_case.dart';

@injectable
class SignInViewModelCubit extends Cubit<SignInViewModelState> {
  SignInAuthUseCase signInAuthUseCase;
  @factoryMethod
  SignInViewModelCubit(this.signInAuthUseCase) : super(SignInViewModelInitial());

  void signIn(String email, String password) async {
    emit(SignInViewModelOnLoading());
    var result = await signInAuthUseCase.callSignIn(email: email, password: password);
    result?.fold((authEntity) {
      emit(SignInViewModelOnSuccess(authEntity));
      SharedPreferenceHelper.saveToken(authEntity.token ?? '');
    }, (error) {
      emit(SignInViewModelOnError(error));
    });
  }

  bool passwordVisible = true;
  void togglePassword() {
    passwordVisible = !passwordVisible;
    emit(SignInViewModelTogglePassword());
  }
}
