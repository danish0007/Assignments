/// Thrown during the sign up process on failure.
class SignUpFailure implements Exception {}

/// Thrown during the login process on failure.
/// errCode is used to determine the type of Error.
class LogInWithEmailAndPasswordFailure implements Exception {
  /// LogInWithEmailAndPasswordFailure constructor
  LogInWithEmailAndPasswordFailure({this.errCode = 'unknown'});

  /// final field of type String
  final String errCode;
}

class ForgotPasswordFailure implements Exception {
  /// LogInWithEmailAndPasswordFailure constructor
  ForgotPasswordFailure({this.errCode = 'unknown'});

  /// final field of type String
  final String errCode;
}

/// Thrown during the logout process on failure.
class LogOutFailure implements Exception {}
