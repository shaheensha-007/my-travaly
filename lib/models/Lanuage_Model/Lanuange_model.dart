// import 'package:flutter/material.dart';
//
// class LanguageModel {
//   final String name;
//   final Locale locale;
//   final String flag;
//   final String? englishName;
//
//   LanguageModel({
//     required this.name,
//     required this.locale,
//     required this.flag,
//     this.englishName,
//   });
//
//   bool matchesLocale(Locale other) {
//     return locale.languageCode == other.languageCode;
//   }
//
//   static List<LanguageModel> get supportedLanguages => [
//     LanguageModel(
//       name: 'English',
//       englishName: 'English',
//       locale: const Locale('en', 'US'),
//       flag: '🇺🇸',
//     ),
//     LanguageModel(
//       name: 'हिंदी',
//       englishName: 'Hindi',
//       locale: const Locale('hi', 'IN'),
//       flag: '🇮🇳',
//     ),
//     LanguageModel(
//       name: 'മലയാളം',
//       englishName: 'Malayalam',
//       locale: const Locale('ml', 'IN'),
//       flag: '🇮🇳',
//     ),
//     LanguageModel(
//       name: 'தமிழ்',
//       englishName: 'Tamil',
//       locale: const Locale('ta', 'IN'),
//       flag: '🇮🇳',
//     ),
//     LanguageModel(
//       name: 'తెలుగు',
//       englishName: 'Telugu',
//       locale: const Locale('te', 'IN'),
//       flag: '🇮🇳',
//     ),
//     LanguageModel(
//       name: 'ಕನ್ನಡ',
//       englishName: 'Kannada',
//       locale: const Locale('kn', 'IN'),
//       flag: '🇮🇳',
//     ),
//   ];
//
//   static LanguageModel? getByCode(String languageCode) {
//     try {
//       return supportedLanguages.firstWhere(
//             (lang) => lang.locale.languageCode == languageCode,
//       );
//     } catch (e) {
//       return null;
//     }
//   }
//
//   static LanguageModel? getByLocale(Locale locale) {
//     try {
//       return supportedLanguages.firstWhere(
//             (lang) => lang.matchesLocale(locale),
//       );
//     } catch (e) {
//       return null;
//     }
//   }
// }