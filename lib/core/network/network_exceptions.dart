import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'failure.dart';

class NetworkExceptions {
  // Private constructor to prevent instantiation
  NetworkExceptions._();

  /// Converts any exception to a typed Failure object
  static Failure getFailure(dynamic error) {
    final message = handleError(error);
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        return NetworkFailure(message);
      }
      if (error.error is SocketException) {
        return NetworkFailure(message);
      }
      return ServerFailure(message, statusCode: error.response?.statusCode);
    } else if (error is SocketException) {
      return NetworkFailure(message);
    }
    return UnknownFailure(message);
  }

  /// Handles all types of network exceptions and returns user-friendly error messages
  static String handleError(dynamic error) {
    String errorMessage = "unknown_error".tr();

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = "connection_timeout".tr();
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = "send_timeout".tr();
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = "receive_timeout".tr();
          break;
        case DioExceptionType.badCertificate:
          errorMessage = "bad_certificate".tr();
          break;
        case DioExceptionType.badResponse:
          errorMessage = _handleBadResponse(
            error.response?.statusCode,
            error.response?.data,
          );
          break;
        case DioExceptionType.cancel:
          errorMessage = "request_cancelled".tr();
          break;
        case DioExceptionType.connectionError:
          errorMessage = "no_internet_connection".tr();
          break;
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            errorMessage = "no_internet_connection".tr();
          } else {
            errorMessage = "unknown_error".tr();
          }
          break;
        case DioExceptionType.transformTimeout:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    } else if (error is SocketException) {
      errorMessage = "no_internet_connection".tr();
    } else if (error is FormatException) {
      errorMessage = "bad_response_format".tr();
    } else {
      errorMessage = error.toString();
    }

    return errorMessage;
  }

  /// Handles response specific error codes
  static String _handleBadResponse(int? statusCode, dynamic responseData) {
    switch (statusCode) {
      case 400:
        return _getMessageFromResponse(responseData) ?? "bad_request".tr();
      case 401:
        return _getMessageFromResponse(responseData) ??
            "unauthorized_access".tr();
      case 403:
        return _getMessageFromResponse(responseData) ?? "forbidden_access".tr();
      case 404:
        return _getMessageFromResponse(responseData) ??
            "resource_not_found".tr();
      case 409:
        return _getMessageFromResponse(responseData) ??
            "conflict_occurred".tr();
      case 422:
        return _getMessageFromResponse(responseData) ?? "validation_error".tr();
      case 429:
        return _getMessageFromResponse(responseData) ??
            "too_many_requests".tr();
      case 500:
        return "server_error".tr();
      case 502:
        return "bad_gateway".tr();
      case 503:
        return "service_unavailable".tr();
      default:
        return _getMessageFromResponse(responseData) ??
            "something_went_wrong".tr();
    }
  }

  /// Dynamically extracts user-facing error messages from any response structure
  /// (Map, List, String, or nested dictionaries) without hardcoding specific field keys.
  static String? _getMessageFromResponse(dynamic responseData) {
    if (responseData == null) return null;
    if (responseData is String) {
      final trimmed = responseData.trim();
      return trimmed.isNotEmpty ? trimmed : null;
    }

    if (responseData is List) {
      final messages = responseData
          .map(_getMessageFromResponse)
          .where((m) => m != null && m.isNotEmpty)
          .cast<String>()
          .toList();
      return messages.isNotEmpty ? messages.join('\n') : null;
    }

    if (responseData is Map) {
      // 1. Direct standard message keys if present
      if (responseData['detail'] is String &&
          (responseData['detail'] as String).trim().isNotEmpty) {
        return (responseData['detail'] as String).trim();
      }
      if (responseData['message'] is String &&
          (responseData['message'] as String).trim().isNotEmpty) {
        return (responseData['message'] as String).trim();
      }
      if (responseData['error'] is String &&
          (responseData['error'] as String).trim().isNotEmpty) {
        return (responseData['error'] as String).trim();
      }

      // 2. Iterate dynamically over all entries regardless of key name
      final List<String> extractedMessages = [];
      for (final value in responseData.values) {
        final parsed = _getMessageFromResponse(value);
        if (parsed != null && parsed.isNotEmpty) {
          extractedMessages.add(parsed);
        }
      }

      if (extractedMessages.isNotEmpty) {
        return extractedMessages.join('\n');
      }
    }

    return null;
  }
}
