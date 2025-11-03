import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:metechology/models/simplehostalModel/SimplehostalModel.dart';
import '../../Api/Api_Servies.dart';

class SimplehostalRepository {
  final ApiService _apiService = ApiService();


  Future<SimplehostalModel> simplehostal() async {
    try {
      // 🔹 Prepare request body
      final Map<String, dynamic> body = {
        "action": "searchAutoComplete",
        "searchAutoComplete": {
          "inputText": 'indi',
          "searchType": [
            "byCity",
            "byState",
            "byCountry",
            "byRandom",
            "byPropertyName"
          ],
          "limit": 10
        }
      };

      debugPrint("📤 Request Body: $body");

      // 🔹 Send API Request
      Response response = await _apiService.post('', data: body);
      debugPrint("📡 API Response: ${response.data}");

      // ✅ Handle response by status code
      switch (response.statusCode) {
        case 200:
        case 201:
          if (response.data['status'] == true) {
            debugPrint("✅ searchAutoComplete Success");
            return SimplehostalModel.fromJson(response.data);
          } else {
            debugPrint("⚠️ API returned false status: ${response.data}");
            throw Exception(response.data['message'] ?? 'Request failed');
          }

        case 400:
          throw Exception("Bad Request (400): Invalid parameters");
        case 401:
          throw Exception("Unauthorized (401): Check authentication");
        case 403:
          throw Exception("Forbidden (403): Access denied");
        case 404:
          throw Exception("Not Found (404): Endpoint not available");
        case 500:
          throw Exception("Server Error (500): Internal server issue");
        default:
          throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      // 🔹 Handle Dio-specific errors
      debugPrint("❌ Dio Error: ${e.message}");
      if (e.response != null) {
        debugPrint("📦 Dio Response Data: ${e.response?.data}");
      }
      throw Exception('${e.message}');
    } catch (e) {
      // 🔹 Handle any other unexpected errors
      debugPrint("⚠️ Unexpected Error: $e");
      rethrow;
    }
  }
}
