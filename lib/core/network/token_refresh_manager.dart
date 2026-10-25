import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/helpers/secure_storage_helper.dart';
import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/routing/app_router.dart';
import 'package:looks_loop/core/routing/routes.dart';

/// Coordinates token refreshing, race-condition handling, and session invalidation.
class TokenRefreshManager {
  TokenRefreshManager._();

  static bool _isNavigatingToLogin = false;
  static Future<String?>? _refreshFuture;

  static void _log(String message, {int level = 0, Object? error}) {
    if (kDebugMode) {
      developer.log(message, name: 'Token-Refresh', level: level, error: error);
    }
  }

  /// Refreshes the access token using a single shared Future for concurrent requests.
  static Future<String?> refresh(String refreshToken) async {
    _refreshFuture ??= _performTokenRefresh(refreshToken);
    return await _refreshFuture;
  }

  static Future<String?> _performTokenRefresh(String refreshToken) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final response = await dio.post(
        ApiEndpoints.refreshToken,
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        String? newAccess;
        String? newRefresh;

        if (data is Map<String, dynamic>) {
          if (data['data'] != null && data['data'] is Map<String, dynamic>) {
            final innerData = data['data'] as Map<String, dynamic>;
            newAccess =
                innerData['access']?.toString() ??
                innerData['access_token']?.toString();
            newRefresh =
                innerData['refresh']?.toString() ??
                innerData['refresh_token']?.toString();
          } else {
            newAccess =
                data['access']?.toString() ?? data['access_token']?.toString();
            newRefresh =
                data['refresh']?.toString() ??
                data['refresh_token']?.toString();
          }
        }

        if (newAccess != null && newAccess.isNotEmpty) {
          await SecureStorageHelper.saveAccessToken(newAccess);
          if (newRefresh != null && newRefresh.isNotEmpty) {
            await SecureStorageHelper.saveRefreshToken(newRefresh);
          }
          return newAccess;
        }
      }
    } catch (e, stackTrace) {
      _log('Error performing token refresh: $e', level: 1000, error: e);
      if (kDebugMode) {
        developer.log('$stackTrace', name: 'Token-Refresh');
      }
    } finally {
      _refreshFuture = null;
    }
    return null;
  }

  /// Clears stored credentials and navigates the user to the login route.
  static Future<void> handleRefreshFailure() async {
    _log('Refresh token failed, clearing session and routing to login.');
    await SecureStorageHelper.clearAll();
    if (!_isNavigatingToLogin) {
      _isNavigatingToLogin = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          AppRouter.router.go(Routes.login);
        } catch (e) {
          _log('Error navigating to login: $e', level: 1000, error: e);
        } finally {
          _isNavigatingToLogin = false;
        }
      });
    }
  }
}
