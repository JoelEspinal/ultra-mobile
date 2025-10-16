abstract class Failure {
  final String message;
  const Failure(this.message);
}

// ----------------------------------------------------
// Subclasses representing business-meaningful failures:
// ----------------------------------------------------

// 1. Connection/Network Failures
class ServerFailure extends Failure {
  const ServerFailure(String message) : super('Server Error: $message');
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super('Cache Error: $message');
}

class NetworkFailure extends Failure {
  const NetworkFailure()
    : super('No Internet Connection. Please check your network.');
}

// 2. API-Specific Failures (often mapped from 4xx/5xx codes)
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure()
    : super('Authentication failed. Please log in again.');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(String resource)
    : super('$resource was not found on the server.');
}

class InvalidDataFailure extends Failure {
  const InvalidDataFailure()
    : super('The server returned invalid or unexpected data.');
}
