/// {@template sd.exception}
/// Base exception
///
/// {@endtemplate}
class SDException implements Exception {
  /// {@macro sd.exception}
  const SDException([this.msg, this.parent, this.source]);

  /// final field of type String
  final String? msg;

  /// final field of type Exception
  final Exception? parent;

  /// final field of type Type
  final Type? source;

  @override
  String toString() {
    return parent.toString();
  }
}

/// {@template sd.repo.operation.failed.exception}
/// Exception used in Repositories to pass on the error
/// when a db operation fails.
///
/// {@endtemplate}
class SDRepoException extends SDException {
  /// {@macro sd.repo.operation.failed.exception}
  const SDRepoException([String? msg, Exception? parent, Type? source])
      : super(msg, parent, source);
}

/// {@template sd.service.operation.failed.exception}
/// Exception used in Services to handle bussiness logic error.
///
/// {@endtemplate}
class SDServiceException extends SDException {
  /// {@macro od.service.operation.failed.exception}
  const SDServiceException([String? msg, Exception? parent, Type? source])
      : super(msg, parent, source);
}
