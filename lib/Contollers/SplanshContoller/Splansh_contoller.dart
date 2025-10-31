import 'package:flutter/material.dart';

class SplashController with ChangeNotifier {
  late final AnimationController _controller;
  late final Animation<double> fade;
  late final Animation<Offset> slide;
  late final Animation<double> scale;

  AnimationController get controller => _controller;
  SplashController(TickerProvider vsync, {Duration duration = const Duration(seconds: 2)}) {
    _controller = AnimationController(vsync: vsync, duration: duration);
    fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    scale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  Future<void> startAndNavigate(BuildContext context, Widget nextPage) async {
    await _controller.forward();

    // tiny pause so the user sees the final logo
    await Future.delayed(const Duration(milliseconds: 300));

    if (!context.mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => nextPage),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}