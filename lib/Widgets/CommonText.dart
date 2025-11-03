import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../getx_controller/Lanunage_Contoller/Lanuange_Controller.dart';

class TranslatorWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const TranslatorWidget({
    super.key,
    required this.text,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  @override
  State<TranslatorWidget> createState() => _TranslatorWidgetState();
}

class _TranslatorWidgetState extends State<TranslatorWidget> {
  final translator = GoogleTranslator();
  final languageController = Get.find<LanguageController>();

  String translatedText = '';
  bool isLoading = true;
  bool hasError = false;
  String currentLanguage = '';

  @override
  void initState() {
    super.initState();
    currentLanguage = languageController.selectedLanguage.value;
    _translateText();

    // Listen for language changes
    ever(languageController.selectedLanguage, (_) {
      if (mounted) {
        _translateText();
      }
    });
  }

  Future<void> _translateText() async {
    final targetLanguage = languageController.selectedLanguage.value;

    // If English, no need to translate
    if (targetLanguage == 'en') {
      setState(() {
        translatedText = widget.text;
        isLoading = false;
        hasError = false;
        currentLanguage = targetLanguage;
      });
      return;
    }

    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final translation = await translator.translate(
        widget.text,
        from: 'en',
        to: targetLanguage,
      );

      if (mounted) {
        setState(() {
          translatedText = translation.text;
          isLoading = false;
          currentLanguage = targetLanguage;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          hasError = true;
          isLoading = false;
          translatedText = widget.text;
          currentLanguage = targetLanguage;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: (widget.style?.fontSize ?? 14) + 4,
        width: (widget.style?.fontSize ?? 14) + 4,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.style?.color ?? Colors.black,
          ),
        ),
      );
    }

    return Text(
      translatedText,
      style: widget.style,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      textAlign: widget.textAlign,
    );
  }
}