import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../getx_controller/Lanunage_Contoller/Lanuange_Controller.dart';

class LanguageSelector extends StatelessWidget {
  final bool showLabel;
  final Color? backgroundColor;
  final Color? textColor;

  const LanguageSelector({
    super.key,
    this.showLabel = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: languageController.selectedLanguage.value,
          icon: Icon(Icons.language, size: 20, color: textColor),
          dropdownColor: backgroundColor ?? Colors.white,
          items: LanguageController.languages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(
                showLabel ? entry.value : entry.key.toUpperCase(),
                style: TextStyle(color: textColor ?? Colors.black),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              languageController.changeLanguage(newValue);
            }
          },
        ),
      ),
    ));
  }
}