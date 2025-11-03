import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  final RxString selectedLanguage = 'en'.obs;

  static const Map<String, String> languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'pt': 'Portuguese',
    'ru': 'Russian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'zh-cn': 'Chinese',
    'ar': 'Arabic',
    'hi': 'Hindi',
    'bn': 'Bengali',
    'ml': 'Malayalam',
    'ta': 'Tamil',
    'te': 'Telugu',
  };

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  // Load saved language from SharedPreferences
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString('selected_language') ?? 'en';
      selectedLanguage.value = savedLanguage;
    } catch (e) {
      print('Error loading language: $e');
    }
  }

  // Change language and save to SharedPreferences
  Future<void> changeLanguage(String languageCode) async {
    try {
      selectedLanguage.value = languageCode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_language', languageCode);
    } catch (e) {
      print('Error saving language: $e');
    }
  }

  String getLanguageName() {
    return languages[selectedLanguage.value] ?? 'English';
  }
}