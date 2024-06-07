import 'package:flutter_ecommerce_app/core/network/internet_checker.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/authentication/data/services/AppleSignInHelper.dart';
import 'package:flutter_ecommerce_app/features/authentication/presentation/manager/sign_in/signin_view_model_state.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../../core/global/global_imports.dart';
import '../../../../../core/local/shared_preference_helper.dart';
import '../../../data/models/UserModel.dart';
import '../../../data/services/GoogleSignInHelper.dart';
import '../../../domain/use_cases/signin_auth_use_case.dart';

@injectable
class SignInViewModelCubit extends Cubit<SignInViewModelState> {
  SignInAuthUseCase signInAuthUseCase;
  final GoogleSignInHelper _googleSignInService;
  final AppleSignInHelper _appleSignInHelper;

  @factoryMethod
  SignInViewModelCubit(this.signInAuthUseCase, this._googleSignInService, this._appleSignInHelper) : super(SignInViewModelInitial());

  void signIn(String email, String password) async {
    if (await CheckInternetConnection.checkConnectivity()) {
      emit(SignInViewModelOnLoading());
      var result = await signInAuthUseCase.callSignIn(email: email, password: password);
      result?.fold((authEntity) {
        emit(SignInViewModelOnSuccess(authEntity));
        SharedPreferenceHelper.saveData(key: StringsManager.keyToken, value: authEntity.token ?? '');
      }, (error) {
        emit(SignInViewModelOnError(error));
      });
    }
  }

  bool passwordVisible = true;

  void togglePassword() {
    passwordVisible = !passwordVisible;
    emit(SignInViewModelTogglePassword());
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(GoogleAuthLoading());

      final googleUser = await _googleSignInService.signIn();
      if (googleUser == null) {
        emit(GoogleAuthError('Google Sign-In failed'));
        return;
      }

      final authentication = await googleUser.authentication;
      final accessToken = authentication.accessToken;

      final user = UserModel(
        googleId: googleUser.id,
        email: googleUser.email,
        accessToken: accessToken,
        displayName: googleUser.displayName ?? '',
        photoUrl: googleUser.photoUrl,
      );

      emit(GoogleAuthSuccess(user));
    } catch (e) {
      emit(GoogleAuthError('Error: $e'));
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await _googleSignInService.signOut();
      emit(SignInViewModelInitial());
    } catch (e) {
      emit(GoogleAuthError('Error signing out: $e'));
    }
  }

  Future<void> signOut() async {
    try {
      await SignInWithApple.getKeychainCredential();
      // Perform any additional cleanup or navigation after sign-out
    } catch (error) {
      print('Error signing out: $error');
    }
  }

  Future<void> signInWithApple() async {
    try {
      emit(AppleAuthLoading());

      // final credential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      //   webAuthenticationOptions: WebAuthenticationOptions(
      //     clientId: StringsManager.clientID,
      //     redirectUri: Uri.parse(StringsManager.redirectUrl),
      //   ),
      // );

      final appleUser = await _appleSignInHelper.signIn();
      if (appleUser == null) {
        emit(AppleAuthError('Apple Sign-In failed'));
        return;
      }
      //Unique info
      print('User ID: ${appleUser.userIdentifier ?? "N/A"}');
      print('IdentityToken: ${appleUser.identityToken ?? "N/A"}');
      print('Email: ${appleUser.email ?? "N/A"}');
      print('Name: ${appleUser.givenName ?? "N/A"} ${appleUser.familyName ?? "N/A"}');

      emit(
        AppleAuthSuccess(
          UserModel(
              accessToken: appleUser.userIdentifier,
              name: '${appleUser.givenName ?? "N/A"} ${appleUser.familyName ?? "N/A"}',
              email: appleUser.email ?? "N/A"),
        ),
      );
      // Send the tokens to your server
      // await sendTokensToServer(idToken, authorizationCode, 'apple');
    } catch (error) {
      emit(AppleAuthError('Error: $error'));
    }
  }
}
