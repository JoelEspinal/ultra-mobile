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

class ValidationFailure extends Failure {
  const ValidationFailure() : super("Todo title cannot be empty.");
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message)
      : super('An unexpected error occurred: $message');
}

// ----------   Local Failures   ---------------

class UnableSyncFailure extends Failure {
  const UnableSyncFailure() : super("Todo title cannot be empty.");
}

class UnableToFindKeyFailure extends Failure {
  const UnableToFindKeyFailure(String message)
      : super("Cannot find key for id = $message");
}

class UnableToSaveLocalListFailure extends Failure {
  const UnableToSaveLocalListFailure(String message)
      : super("Unable to save all local todos: $message");
}

class UnableDeleteFailure extends Failure {
  const UnableDeleteFailure(String message)
      : super("Unable to delete local todos: $message");
}

class UnableUpdateFailure extends Failure {
  const UnableUpdateFailure(
    String message,
  ) : super("Unable to update local todos: $message");
}

class UnableOpenBox extends Failure {
  const UnableOpenBox(
    String message,
  ) : super("Unable to check Hive Box: $message");
}

class UnableToObtainAllTodos extends Failure {
  const UnableToObtainAllTodos(
    String message,
  ) : super("Unable to get all todos: $message");
}

class UnableToAddTodos extends Failure {
  const UnableToAddTodos(
    String message,
  ) : super("Unable to add all todos: $message");
}

class UnableToAddTodo extends Failure {
  const UnableToAddTodo(
    String message,
  ) : super("Unable to add todo: $message");
}

class UnableToAddLocalTodos extends Failure {
  const UnableToAddLocalTodos(
    String message,
  ) : super("Unable to add local todos: $message");
}

class UnableToFindLocalTodo extends Failure {
  const UnableToFindLocalTodo(
    String message,
  ) : super("Unable to find local todos: $message");
}

class FavoriteIsNullFailure extends Failure {
  const FavoriteIsNullFailure(
    String message,
  ) : super("Cannot assign to null Value: $message");
}

class UnableToFindTodoFailure extends Failure {
  const UnableToFindTodoFailure(String message)
      : super("Cannot find Todo for id = $message");
}

class CannotUpdateNullValueFailure extends Failure {
  const CannotUpdateNullValueFailure(
    String message,
  ) : super("Cannot update null Value: $message");
}

class CannotUpdateToggleCompleteFailure extends Failure {
  const CannotUpdateToggleCompleteFailure(
    String message,
  ) : super("Cannot update completed Todo: $message");
}
