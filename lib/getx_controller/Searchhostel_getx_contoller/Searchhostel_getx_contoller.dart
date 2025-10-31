import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/Searchpage/View data  customer.dart';
import '../../core/Repository/searchHostal_Api/Searchhostal Api.dart';
import '../../models/SearchHostalModel/SearchHostalModel.dart';

class SearchhotelGetx extends GetxController {
  final SerachhostalRepository _serachhostalRepository = SerachhostalRepository();

  // Observables
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final Searchhostaldata = Rxn<SearchHostelModel>();

  @override
  void onInit() {
    super.onInit();
    debugPrint('🎯 SearchhotelGetx Controller Initialized');

    // Listen to changes in Searchhostaldata for debugging
    ever(Searchhostaldata, (data) {
      debugPrint('🔄 Searchhostaldata changed!');
      debugPrint('🔍 Data is null: ${data == null}');
      debugPrint('🔍 Hotels count: ${data?.data?.arrayOfHotelList?.length ?? 0}');
    });
  }

  Future<void> searchhostal(
      String checkIn,
      String checkOut,
      int rooms,
      int adults,
      int children,
      String searchType,
      List<String> searchQuery,
      List<String> accommodation,
      List<String> excludedSearch,
      String highPrice,
      String lowPrice,
      ) async {
    try {
      debugPrint('═══════════════════════════════════════');
      debugPrint('🔄 Starting hotel search...');
      debugPrint('📅 CheckIn: $checkIn, CheckOut: $checkOut');
      debugPrint('👥 Rooms: $rooms, Adults: $adults, Children: $children');
      debugPrint('🔍 Search Type: $searchType');
      debugPrint('🔍 Search Query: $searchQuery');

      // Set loading state
      isLoading.value = true;
      errorMessage.value = '';

      // Clear previous data to force UI refresh
      Searchhostaldata.value = null;

      debugPrint('✅ Loading state set, starting API call...');

      // Call API
      final result = await _serachhostalRepository.getSearchResultListOfHotels(
        checkIn: checkIn,
        checkOut: checkOut,
        rooms: rooms,
        adults: adults,
        children: children,
        searchType: searchType,
        searchQuery: searchQuery,
        accommodation: accommodation,
        excludedSearchType: excludedSearch,
        highPrice: highPrice,
        lowPrice: lowPrice,
      );

      debugPrint('✅ API call returned successfully');
      debugPrint('📊 Result status: ${result.status}');
      debugPrint('📊 Result message: ${result.message}');
      debugPrint('📊 Result code: ${result.responseCode}');
      debugPrint('📊 Data is null: ${result.data == null}');
      debugPrint('📊 Hotels list is null: ${result.data?.arrayOfHotelList == null}');
      debugPrint('📊 Hotels count: ${result.data?.arrayOfHotelList?.length ?? 0}');

      // Log first hotel if available
      if (result.data?.arrayOfHotelList?.isNotEmpty ?? false) {
        final firstHotel = result.data!.arrayOfHotelList![0];
        debugPrint('📊 First hotel name: ${firstHotel.propertyName}');
        debugPrint('📊 First hotel code: ${firstHotel.propertyCode}');
        debugPrint('📊 First hotel price: ${firstHotel.propertyMinPrice?.amount}');
      }

      // CRITICAL: Update the observable
      debugPrint('🔄 Setting Searchhostaldata.value...');
      Searchhostaldata.value = result;

      // Verify the assignment worked
      debugPrint('✅ Data assigned to observable');
      debugPrint('🔍 Observable is null: ${Searchhostaldata.value == null}');
      debugPrint('🔍 Observable hotels count: ${Searchhostaldata.value?.data?.arrayOfHotelList?.length ?? 0}');

      // Small delay to ensure GetX processes the update
      await Future.delayed(const Duration(milliseconds: 100));

      // Turn off loading
      isLoading.value = false;
      debugPrint('✅ Loading state turned off');

      // Check if we have data before navigating
      final hotelsCount = result.data?.arrayOfHotelList?.length ?? 0;

      if (hotelsCount == 0) {
        debugPrint('⚠️ No hotels found in results');
        Get.snackbar(
          "No Results",
          "No hotels found for your search criteria",
          backgroundColor: Colors.orange.shade600,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        );
        // Still navigate to show empty state
      } else {
        debugPrint('✅ Found $hotelsCount hotels, showing success message');
        Get.snackbar(
          "Success",
          "Found $hotelsCount hotel${hotelsCount == 1 ? '' : 's'}",
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      // Navigate to results screen
      debugPrint('🚀 Navigating to results screen...');
      await Get.to(() => const HotelSearchResultsScreen());
      debugPrint('✅ Navigation completed');
      debugPrint('═══════════════════════════════════════');

    } on Exception catch (e) {
      debugPrint('═══════════════════════════════════════');
      debugPrint('❌ Search Exception: $e');

      isLoading.value = false;
      errorMessage.value = e.toString().replaceAll('Exception: ', '');

      Get.snackbar(
        "Error",
        errorMessage.value,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
      );
      debugPrint('═══════════════════════════════════════');

    } catch (e, stackTrace) {
      debugPrint('═══════════════════════════════════════');
      debugPrint('❌ Unexpected error: $e');
      debugPrint('❌ Stack trace: $stackTrace');

      isLoading.value = false;
      errorMessage.value = 'An unexpected error occurred. Please try again.';

      Get.snackbar(
        "Error",
        "Failed to search hotels. Please try again.",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint('═══════════════════════════════════════');
    }
  }

  // Helper method to check if we have valid data
  bool get hasData {
    final hasValidData = Searchhostaldata.value?.data?.arrayOfHotelList?.isNotEmpty ?? false;
    debugPrint('🔍 hasData getter called: $hasValidData');
    return hasValidData;
  }

  // Helper method to get hotels list safely
  List<ArrayOfHotelList> get hotels {
    final hotelsList = Searchhostaldata.value?.data?.arrayOfHotelList ?? [];
    debugPrint('🔍 hotels getter called: ${hotelsList.length} hotels');
    return hotelsList;
  }

  // Method to manually refresh/check data (for debugging)
  void checkData() {
    debugPrint('═══════════════════════════════════════');
    debugPrint('🔍 Manual Data Check:');
    debugPrint('🔍 Searchhostaldata is null: ${Searchhostaldata.value == null}');
    debugPrint('🔍 isLoading: ${isLoading.value}');
    debugPrint('🔍 errorMessage: ${errorMessage.value}');

    if (Searchhostaldata.value != null) {
      debugPrint('🔍 status: ${Searchhostaldata.value!.status}');
      debugPrint('🔍 message: ${Searchhostaldata.value!.message}');
      debugPrint('🔍 data is null: ${Searchhostaldata.value!.data == null}');

      if (Searchhostaldata.value!.data != null) {
        final hotels = Searchhostaldata.value!.data!.arrayOfHotelList;
        debugPrint('🔍 arrayOfHotelList is null: ${hotels == null}');
        debugPrint('🔍 Hotels count: ${hotels?.length ?? 0}');

        if (hotels?.isNotEmpty ?? false) {
          debugPrint('🔍 First hotel: ${hotels![0].propertyName}');
        }
      }
    }
    debugPrint('═══════════════════════════════════════');
  }

  @override
  void onClose() {
    debugPrint('🔴 SearchhotelGetx Controller Disposed');
    super.onClose();
  }
}