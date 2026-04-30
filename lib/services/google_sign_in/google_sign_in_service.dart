import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> initialize({String? clientId, String? serverClientId}) async {
    await _googleSignIn.initialize(
      clientId: clientId,
      serverClientId: serverClientId,
    );
    _googleSignIn.authenticationEvents
        .listen(_onAuthEvent)
        .onError(_onAuthError);
    _googleSignIn.attemptLightweightAuthentication();
  }

  void _onAuthEvent(GoogleSignInAuthenticationEvent event) {
    debugPrint('GoogleSignIn event: $event');
  }

  void _onAuthError(Object error) {
    debugPrint('GoogleSignIn error: $error');
  }

  Future<String?> getIdToken() async {
    try {
      if (!_googleSignIn.supportsAuthenticate()) {
        debugPrint('GoogleSignIn: platform does not support authenticate()');
        return null;
      }
      final account = await _googleSignIn.authenticate();
      final idToken = account.authentication.idToken;
      debugPrint(
        'GoogleSignIn idToken: ${idToken != null ? '${idToken.substring(0, 20)}...' : 'NULL'}',
      );
      return idToken;
    } catch (e) {
      debugPrint('GoogleSignIn getIdToken error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
