import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/domain/entities/auth_entity/AuthEntity.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/auth/signin_auth_use_case.dart';

part 'signin_view_model_state.dart';

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
    }, (error) {
      emit(SignInViewModelOnError(error));
    });
  }
}
