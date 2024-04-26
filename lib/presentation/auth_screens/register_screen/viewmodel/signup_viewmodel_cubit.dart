import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/auth_entity/AuthEntity.dart';
import '../../../../domain/usecases/auth/signup_auth_use_case.dart';

part 'signup_viewmodel_state.dart';

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
}
