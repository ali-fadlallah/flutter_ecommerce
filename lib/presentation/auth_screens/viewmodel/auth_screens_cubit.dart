import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_screens_state.dart';

@injectable
class AuthScreensCubit extends Cubit<AuthScreensState> {
  @factoryMethod
  AuthScreensCubit() : super(AuthScreensInitial());

  bool passwordVisible = false;
  void togglePassword() {
    passwordVisible = !passwordVisible;
    emit(AuthScreensTogglePassword());
  }
}
