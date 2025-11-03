import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
    baseUrl: 'https://api.mytravaly.com/public/v1/', // ✅ Base URL
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'authtoken': '71523fdd8d26f585315b4233e39d9263',

    },
  )) {
    // ✅ Add interceptor for visitorToken
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final visitorToken = prefs.getString('visitorToken');

        if (visitorToken != null && visitorToken.isNotEmpty) {
          options.headers['visitorToken'] = visitorToken; // 🔹 Add token header
        }

        return handler.next(options);
      },
    ));

    // ✅ Optional: log all requests & responses
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  // ✅ GET method
  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ✅ POST method
  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ✅ PUT method
  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ✅ DELETE method
  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // 🔥 Centralized error handler
  void _handleError(DioException e) {
    String message = '';
    if (e.type == DioExceptionType.connectionTimeout) {
      message = "Connection Timeout";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      message = "Receive Timeout";
    } else if (e.type == DioExceptionType.badResponse) {
      message =
      "Server Error: ${e.response?.statusCode} → ${e.response?.statusMessage}";
    } else if (e.type == DioExceptionType.unknown) {
      message = "Unexpected error occurred: ${e.message}";
    }
    print('❌ Dio Error: $message');
  }
}
