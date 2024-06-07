import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/utils/strings/strings_manager.dart';

@injectable
class AppleSignInHelper {
  AppleSignInHelper();

  Future<AuthorizationCredentialAppleID?> signIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: StringsManager.clientID,
          redirectUri: Uri.parse(StringsManager.redirectUrl),
        ),
      );
      return credential;
    } catch (error) {
      // Use a proper logging system
      print('Error during Apple sign-in: $error');
      return null;
    }
  }
}
