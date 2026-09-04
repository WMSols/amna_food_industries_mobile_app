import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;

import 'package:amna_food_industries_mobile_app/core/network/api_envelope.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_exception.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_logger.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';
import 'package:amna_food_industries_mobile_app/core/services/connectivity_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/storage_service.dart';

class ApiClient extends GetxService {
  ApiClient(this._storage, this._session) {
    _envelope = ApiEnvelope.fromEnv(dotenv.env['API_ENVELOPE']);

    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? '',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final sessionId = await _storage.getToken();
          if (sessionId != null && sessionId.isNotEmpty) {
            options.headers['Cookie'] = 'session_id=$sessionId';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _session.clearSession();
            if (Get.currentRoute != AppRoutes.login &&
                Get.currentRoute != AppRoutes.splash) {
              Get.offAllNamed(AppRoutes.login);
            }
          }
          handler.next(error);
        },
      ),
    );
    _dio.interceptors.add(ApiLogger.interceptor());
  }

  final StorageService _storage;
  final SessionService _session;
  late final Dio _dio;
  late final ApiEnvelope _envelope;

  String get odooDatabase => dotenv.env['ODOO_DATABASE'] ?? '';

  bool get hasBaseUrl {
    final url = dotenv.env['API_BASE_URL'] ?? '';
    return url.trim().isNotEmpty;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      _ensureConnectivity();
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      _ensureConnectivity();
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _mapException(e);
    }
  }

  Future<Map<String, dynamic>> getData(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await get<dynamic>(path, queryParameters: queryParameters);
    return _envelope.unwrap(response.data);
  }

  Future<Map<String, dynamic>> postData(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    final response = await post<dynamic>(path, data: data ?? const {});
    return _envelope.unwrap(response.data);
  }

  Map<String, dynamic> unwrapData(dynamic raw) => _envelope.unwrap(raw);

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      _ensureConnectivity();
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _mapException(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      _ensureConnectivity();
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _mapException(e);
    }
  }

  void _ensureConnectivity() {
    if (!Get.isRegistered<ConnectivityService>()) return;
    Get.find<ConnectivityService>().ensureOnline();
  }

  ApiException _mapException(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    final message = switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => 'Connection timed out',
      DioExceptionType.connectionError => 'No internet connection',
      _ => _extractMessage(data) ?? e.message ?? 'Request failed',
    };
    return ApiException(message: message, statusCode: status, data: data);
  }

  String? _extractMessage(dynamic data) {
    if (data is Map) {
      if (data['error'] != null) return data['error'].toString();
      if (data['message'] != null) return data['message'].toString();
      if (data['arguments'] is List && (data['arguments'] as List).isNotEmpty) {
        return (data['arguments'] as List).first.toString();
      }
    }
    return null;
  }
}
