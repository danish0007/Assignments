import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:logging/logging.dart';
import 'package:stockdaddy/exceptions/sd_firebase_auth_exceptions.dart';

class SDFirebaseAuthRepo {
  /// {@macro sd.auth.repo} Constructor
  SDFirebaseAuthRepo({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _log = Logger('[SDFirebaseAuthRepo] >>>>');

  /// {@macro sd.auth.repo.signUp}
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _log.fine('User signed up with $email');
    } on Exception catch (it) {
      _log.warning('Unable to sign up user with $email', it);
      throw SignUpFailure();
    }
  }

  /// {@macro sd.auth.repo.logOut}
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
      _log.fine('Logged out user');
    } on Exception catch (it) {
      _log.warning('Unable to log out user', it);
      throw LogOutFailure();
    }
  }

  /// {@macro sd.auth.repo.logInWithEmailAndPassword}
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _log.fine('Logged in with $email');
    } on firebase_auth.FirebaseAuthException catch (it) {
      _log.warning('Unable to log in using $email', it);
      throw LogInWithEmailAndPasswordFailure(
        errCode: it.code,
      );
    } on Exception catch (it) {
      _log.shout('unknown exception encountered', it);
      rethrow;
    }
  }
}
