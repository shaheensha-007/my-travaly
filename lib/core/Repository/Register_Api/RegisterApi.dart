import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../getx_controller/Simplehostal_getx_controller/simplehostal_getx.dart';
import '../../../models/RegistationDeviceModel/RegistationDeviceModel.dart';
import '../../Api/Api_Servies.dart';

class RegistrationRepository {
  final ApiService apiService;
  static const String _visitorTokenKey = 'visitorToken';

  RegistrationRepository(this.apiService);

  /// Registers the device and returns registration data
  Future<RegistationDeviceModel> registerDevice() async {
    try {
      final deviceData = await _collectDeviceInfo();
      final body = {
        "action": "deviceRegister",
        "deviceRegister": deviceData,
      };

      debugPrint("📱 Device Register Request: $body");

      final response = await _sendRegistrationRequest(body);

      debugPrint("📡 API Response: ${response.data}");

      return await _handleSuccessfulResponse(response);
    } on DioException catch (e) {
      debugPrint("❌ Dio Error: ${e.response?.data ?? e.message}");
      throw _handleDioException(e);
    } catch (e) {
      debugPrint("⚠️ Unexpected Error: $e");
      rethrow;
    }
  }

  /// Collects device information based on platform
  Future<Map<String, dynamic>> _collectDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (defaultTargetPlatform == TargetPlatform.android) {
      return await _getAndroidDeviceInfo(deviceInfo);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return await _getIOSDeviceInfo(deviceInfo);
    } else {
      return _getUnknownDeviceInfo();
    }
  }

  /// Gets Android device information
  Future<Map<String, dynamic>> _getAndroidDeviceInfo(
      DeviceInfoPlugin deviceInfo) async {
    final androidInfo = await deviceInfo.androidInfo;
    return {
      "deviceModel": androidInfo.model,
      "deviceFingerprint": androidInfo.fingerprint,
      "deviceBrand": androidInfo.brand,
      "deviceId": androidInfo.id,
      "deviceName": androidInfo.device,
      "deviceManufacturer": androidInfo.manufacturer,
      "deviceProduct": androidInfo.product,
      "deviceSerialNumber": androidInfo.id,
    };
  }

  /// Gets iOS device information
  Future<Map<String, dynamic>> _getIOSDeviceInfo(
      DeviceInfoPlugin deviceInfo) async {
    final iosInfo = await deviceInfo.iosInfo;
    return {
      "deviceModel": iosInfo.utsname.machine,
      "deviceFingerprint": iosInfo.identifierForVendor ?? "unknown",
      "deviceBrand": "Apple",
      "deviceId": iosInfo.identifierForVendor ?? "unknown",
      "deviceName": iosInfo.name,
      "deviceManufacturer": "Apple",
      "deviceProduct": iosInfo.model,
      "deviceSerialNumber": "unknown",
    };
  }

  /// Returns unknown device info for unsupported platforms
  Map<String, dynamic> _getUnknownDeviceInfo() {
    return {
      "deviceModel": "unknown",
      "deviceFingerprint": "unknown",
      "deviceBrand": "unknown",
      "deviceId": "unknown",
      "deviceName": "unknown",
      "deviceManufacturer": "unknown",
      "deviceProduct": "unknown",
      "deviceSerialNumber": "unknown",
    };
  }

  /// Sends registration request to API
  Future<Response> _sendRegistrationRequest(Map<String, dynamic> body) async {
    return await apiService.post('', data: body);
  }

  /// Handles successful API response
  Future<RegistationDeviceModel> _handleSuccessfulResponse(
      Response response) async {
    // Validate response
    if (!_isValidResponse(response)) {
      final errorMessage = response.data['message'] ?? 'Registration failed';
      debugPrint("❌ Device registration failed: $errorMessage");
      throw Exception(errorMessage);
    }

    // Extract and save token
    final token = response.data['data']?['visitorToken'];
    if (token != null && token.toString().isNotEmpty) {
      await _saveVisitorToken(token.toString());
    } else {
      debugPrint("⚠️ Warning: No visitor token received");
    }

    // Trigger GetX controller update
    try {
      Get.find<SimplehotelGetx>().simplehostal();
    } catch (e) {
      debugPrint("⚠️ Warning: Could not update SimplehotelGetx: $e");
    }

    debugPrint("✅ Device Registered Successfully!");
    return RegistationDeviceModel.fromJson(response.data);
  }

  /// Validates if the response is successful
  bool _isValidResponse(Response response) {
    return (response.statusCode == 200 || response.statusCode == 201) &&
        response.data != null &&
        response.data['status'] == true;
  }

  /// Saves visitor token to SharedPreferences
  Future<void> _saveVisitorToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_visitorTokenKey, token);
      debugPrint("🔐 visitorToken saved: $token");
    } catch (e) {
      debugPrint("⚠️ Failed to save visitor token: $e");
      // Don't throw - token saving failure shouldn't break registration
    }
  }

  /// Handles DioException and converts to meaningful exception
  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout. Please check your internet.');
      case DioExceptionType.sendTimeout:
        return Exception('Request timeout. Please try again.');
      case DioExceptionType.receiveTimeout:
        return Exception('Server response timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Server error';
        return Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      default:
        return Exception('Network error: ${e.message}');
    }
  }

  /// Retrieves stored visitor token
  Future<String?> getVisitorToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_visitorTokenKey);
    } catch (e) {
      debugPrint("⚠️ Failed to retrieve visitor token: $e");
      return null;
    }
  }

  /// Clears stored visitor token
  Future<void> clearVisitorToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_visitorTokenKey);
      debugPrint("🗑️ Visitor token cleared");
    } catch (e) {
      debugPrint("⚠️ Failed to clear visitor token: $e");
    }
  }
}