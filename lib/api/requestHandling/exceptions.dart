import 'dart:io';

class HttpStatusException implements Exception {
  const HttpStatusException(this.statusCode, this.message)
      : assert(statusCode != null),
        assert(message != null);

  final int statusCode;
  final String message;

  @override
  String toString() => 'HTTP $statusCode: $message';
}

class BadRequestException extends HttpStatusException {
  const BadRequestException([String message = 'Bad request'])
      : super(HttpStatus.badRequest, message);
}

class Unauthorized extends HttpStatusException {
  const Unauthorized([String message = 'Unauthorized'])
      : super(HttpStatus.unauthorized, message);
}

class Forbidden extends HttpStatusException {
  const Forbidden([String message = 'Forbidden'])
      : super(HttpStatus.forbidden, message);
}

class NotFoundException extends HttpStatusException {
  const NotFoundException(String missing)
      : assert(missing != null),
        super(HttpStatus.notFound, 'Not found: $missing');
}

class MethodNotAllowed extends HttpStatusException {
  const MethodNotAllowed(String method)
      : super(HttpStatus.methodNotAllowed, 'Unsupported method: $method');
}

class InternalServerError extends HttpStatusException {
  const InternalServerError([String message = 'Internal server error'])
      : super(HttpStatus.internalServerError, message);
}