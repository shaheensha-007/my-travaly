import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:metechology/Widgets/Navigationservice.dart';
import 'package:metechology/models/SearchHostalModel/SearchHostalModel.dart';
import '../../../views/Searchpage/View data  customer.dart';
import '../../Api/Api_Servies.dart';

class SerachhostalRepository {
  final ApiService _apiService = ApiService();

  /// 🔹 Fetch hotel search results with dynamic parameters
  Future<SearchHostelModel> getSearchResultListOfHotels({
    required String checkIn,
    required String checkOut,
    required int rooms,
    required int adults,
    required int children,
    required String searchType,
    required List<String> searchQuery,
    required List<String> accommodation,
    required List<String> excludedSearchType,
    required String highPrice,
    required String lowPrice,
    int limit = 5,
    String currency = "INR",
    int rid = 0,
  }) async {
    try {
      // 🔹 Prepare request body (matching the working format)
      final Map<String, dynamic> body = {
        "action": "getSearchResultListOfHotels",
        "getSearchResultListOfHotels": {
          "searchCriteria": {
            "checkIn": checkIn,
            "checkOut": checkOut,
            "rooms": rooms,
            "adults": adults,
            "children": children,
            "searchType": searchType,
            "searchQuery": searchQuery,
            "accommodation": accommodation, // ✅ No default empty array
            "arrayOfExcludedSearchType": excludedSearchType,
            "highPrice": highPrice,
            "lowPrice": lowPrice,
            "limit": limit,
            "preloaderList": [],
            "currency": currency,
            "rid": rid,
          }
        }
      };

      debugPrint("📤 Hotel Search Request Body: $body");

      // 🔹 Send API Request
      Response response = await _apiService.post('', data: body);
      debugPrint("📡 API Response: ${response.data}");

      // ✅ Handle response by status code
      switch (response.statusCode) {
        case 200:
        case 201:
          if (response.data['status'] == true) {
            debugPrint("✅ getSearchResultListOfHotels Success");
            // Don't navigate here - let the controller handle it
            return SearchHostelModel.fromJson(response.data);
          } else {
            debugPrint("⚠️ API returned false: ${response.data}");
            throw Exception(response.data['message'] ?? 'Request failed');
          }

        case 400:
          final errorMsg = response.data['message'] ?? 'Invalid parameters';
          throw Exception("Bad Request (400): $errorMsg");
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
      debugPrint("❌ Dio Error: ${e.type} → ${e.message}");
      if (e.response != null) {
        debugPrint("📦 Dio Response Status: ${e.response?.statusCode}");
        debugPrint("📦 Dio Response Data: ${e.response?.data}");

        // Extract server error message if available
        if (e.response?.data is Map && e.response?.data['message'] != null) {
          throw Exception('${e.response?.data['message']}');
        }
      }
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      debugPrint("⚠️ Unexpected Error: $e");
      rethrow;
    }
  }
}