import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleSignInHelper {
  @factoryMethod
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
  );

  Future<GoogleSignInAccount?> signIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signInSilently();
      account ??= await _googleSignIn.signIn();
      return account;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> signOut() => _googleSignIn.disconnect();
}
