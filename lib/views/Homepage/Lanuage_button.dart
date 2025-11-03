import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../getx_controller/Lanunage_Contoller/Lanuange_Controller.dart';

class LanguageButton extends StatelessWidget {
  final Color? iconColor;
  final Color? backgroundColor;

  const LanguageButton({
    super.key,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return Obx(() => PopupMenuButton<String>(
      icon: Icon(Icons.translate, color: iconColor ?? Colors.black87),
      tooltip: 'Change Language',
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (String languageCode) {
        languageController.changeLanguage(languageCode);
      },
      itemBuilder: (BuildContext context) {
        return LanguageController.languages.entries.map((entry) {
          final isSelected = entry.key == languageController.selectedLanguage.value;
          return PopupMenuItem<String>(
            value: entry.key,
            child: Row(
              children: [
                if (isSelected)
                  const Icon(Icons.check, color: Colors.blue, size: 20)
                else
                  const SizedBox(width: 20),
                const SizedBox(width: 12),
                Text(
                  entry.value,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.blue : Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
    ));
  }
}