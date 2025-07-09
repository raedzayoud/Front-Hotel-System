import 'package:dio/dio.dart';
import 'dart:io';

abstract class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

class ServeurFailure extends Failure {
  ServeurFailure({required String errorsMessage}) : super(errorsMessage);

  factory ServeurFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServeurFailure(
            errorsMessage: 'Connection timeout with API server');

      case DioExceptionType.sendTimeout:
        return ServeurFailure(errorsMessage: 'Send timeout with API server');

      case DioExceptionType.receiveTimeout:
        return ServeurFailure(errorsMessage: 'Receive timeout with API server');

      case DioExceptionType.badResponse:
        if (dioError.response != null) {
          return ServeurFailure.fromResponse(
            dioError.response!.statusCode ?? 500,
            dioError.response!.data,
          );
        }
        return ServeurFailure(errorsMessage: "Invalid server response");

      case DioExceptionType.cancel:
        return ServeurFailure(
            errorsMessage: 'Request to API server was cancelled');

      case DioExceptionType.connectionError:
        return ServeurFailure(
            errorsMessage: 'Connection error with the server');

      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          return ServeurFailure(errorsMessage: "No internet connection");
        }
        return ServeurFailure(
            errorsMessage: "Unexpected error, please try again");

      default:
        return ServeurFailure(
            errorsMessage: "Something went wrong. Try again later");
    }
  }

  factory ServeurFailure.fromResponse(int statusCode, dynamic response) {
    String message = "Oops, there was an error. Please try again.";

    try {
      // DEBUG: Print response structure
      print("🔍 Response type: ${response.runtimeType}");
      print("📦 Response data: $response");

      if (response is Map<String, dynamic>) {
        if (response.containsKey('message')) {
          message = response['message'].toString();
        } else if (response.containsKey('error')) {
          message = response['error'].toString();
        } else if (response.containsKey('errors')) {
          final errors = response['errors'];
          if (errors is Map && errors.isNotEmpty) {
            final firstKey = errors.keys.first;
            final errorList = errors[firstKey];
            if (errorList is List && errorList.isNotEmpty) {
              message = errorList.first.toString();
            } else {
              message = errorList.toString(); // fallback
            }
          } else {
            message = errors.toString(); // fallback
          }
        }
      } else if (response is String) {
        // Sometimes APIs return plain text
        message = response;
      } else {
        message = "Unrecognized error structure: ${response.toString()}";
      }
    } catch (e) {
      message = "Unexpected error format from server. ${e.toString()}";
    }

    return ServeurFailure(errorsMessage: message);
  }
}
