import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/features/authentication/presentation/manager/sign_up/signup_viewmodel_state.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/signup_auth_use_case.dart';

@injectable
class SignupViewModelCubit extends Cubit<SignupViewModelState> {
  SignUpAuthUseCase signUpAuthUseCase;
  @factoryMethod
  SignupViewModelCubit(this.signUpAuthUseCase) : super(SignupViewModelInitial());

  void signUp({required String name, required String email, required String password, required String phone}) async {
    emit(SignupViewModelOnLoading());
    var result = await signUpAuthUseCase.callSignUp(name: name, email: email, password: password, phone: phone);
    result?.fold((authEntity) {
      emit(SignupViewModelOnSuccess(authEntity));
    }, (error) {
      emit(SignupViewModelOnError(error));
    });
  }

  bool passwordVisible = true;
  void togglePassword() {
    passwordVisible = !passwordVisible;
    emit(SignupViewModelTogglePassword());
  }
}
