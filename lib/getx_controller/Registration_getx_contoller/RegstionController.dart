import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/Repository/Register_Api/RegisterApi.dart';
import '../../models/RegistationDeviceModel/RegistationDeviceModel.dart';

class RegistrationController extends GetxController {
  final RegistrationRepository registrationRepository= RegistrationRepository();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final registrationData = Rxn<RegistationDeviceModel>();

  String get visitorToken =>
      registrationData.value?.data?.visitorToken ?? 'No Token';

  Future<void> registerDevice() async {
    // Do NOT clear registrationData here!
    isLoading(true);
    errorMessage('');

    try {
      final result = await registrationRepository.registerDevice();
      registrationData.value = result;

      // Save token for later sessions
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('visitorToken', result.data?.visitorToken ?? '');

      Get.snackbar(
        "Success",
        "Device registered!",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage(e.toString());

      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}