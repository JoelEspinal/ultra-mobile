import 'package:dio/dio.dart';
import 'dart:io'; // For SocketException

import '../../domain/failures/failure.dart';

// Function to map a technical Exception/Error into a Domain Failure
Failure mapExceptionToFailure(Object e) {
  if (e is DioException) {
    // A. Handle Dio Errors (HTTP status codes, timeouts)
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(); // Use the generic NetworkFailure for timeouts

      case DioExceptionType.badResponse:
        // Check HTTP status code
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 401:
            return const UnauthorizedFailure(); // Map 401 to an Auth Failure
          case 404:
            return const NotFoundFailure('Resource'); // Map 404
          case 400: // Bad Request
          case 422: // Unprocessable Entity
            // You might parse the error message from the body here
            return InvalidDataFailure();
          case 500:
          case 503:
            return ServerFailure(
              'Server is down or busy. Try again later.',
            ); // Map 5xx to Server Failure
          default:
            return ServerFailure(
              'Received unexpected status code: $statusCode',
            );
        }

      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled.');

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        // B. Handle low-level connection errors
        if (e.error is SocketException) {
          return const NetworkFailure(); // Map SocketException (no internet)
        }
        return ServerFailure('An unknown error occurred: ${e.message}');

      case DioExceptionType.badCertificate:
        return ServerFailure('SSL certificate error.');
    }
  }
  // C. Handle data parsing errors
  else if (e is FormatException) {
    return const InvalidDataFailure();
  }

  // D. Fallback for unexpected errors
  return ServerFailure(e.toString());
}
