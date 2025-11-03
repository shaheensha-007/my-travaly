import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metechology/models/simplehostalModel/SimplehostalModel.dart';
import '../../core/Repository/SimpleHostal_Api/Simplehostal_Api.dart';

class SimplehotelGetx extends GetxController {
  final SimplehostalRepository simplehostalRepositor=SimplehostalRepository();


  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final simplehostaldata = Rxn<SimplehostalModel>();


  Future<void> simplehostal() async {
    isLoading(true);
    errorMessage('');

    try {
      final result = await simplehostalRepositor.simplehostal();
      simplehostaldata.value = result;

      Get.snackbar(
        "Success",
        "Search completed!",
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
