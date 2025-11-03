import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:metechology/getx_controller/Lanunage_Contoller/Lanuange_Controller.dart';
import 'package:metechology/getx_controller/Registration_getx_contoller/RegstionController.dart';
import 'package:metechology/getx_controller/Simplehostal_getx_controller/simplehostal_getx.dart';
import 'package:metechology/views/Splansh_Screen/Splansh_screen.dart';
import 'Widgets/Navigationservice.dart';
// import 'package:metechology/translations/app_translations.dart';   // <-- when you have it

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("Firebase connected successfully!");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --------------------------------------------------------------
    // 1. Register ALL controllers **once** before any Get.find()
    // --------------------------------------------------------------
    return GetMaterialApp(
      title: 'Metechology',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData.light(),

      // ---- Locale ------------------------------------------------
      // The locale is taken from the observable in LanguageController.
      // GetMaterialApp automatically rebuilds when it changes.
      locale: Get.find<LanguageController>().currentLocale.value,
      fallbackLocale: const Locale('en', 'US'),

      // ---- Translations (uncomment when you have the class) ------
      // translations: AppTranslations(),

      // ---- First screen -------------------------------------------
      home: const SplashScreen(),

      // ---- Controllers (initialBinding) ---------------------------
      initialBinding: BindingsBuilder(() {
        Get.put(LanguageController());          // language
        Get.put(RegistrationController());      // registration
        Get.put(SimplehotelGetx());             // simple hotel
      }),
    );
  }
}