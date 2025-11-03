import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Contollers/Auth_Controller/Auth_check_contoller.dart';
import '../../Contollers/SplanshContoller/Splansh_contoller.dart';
import '../Signin-up/Signin-up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final SplashController _splashCtrl;

  @override
  void initState() {
    super.initState();

    // Initialize controller with vsync
    _splashCtrl = SplashController(this);
    _splashCtrl.startAndNavigate(context, const AuthChecker());
  }

  @override
  void dispose() {
    _splashCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<Color> gradientColors = [
      Color(0xFF17328D),
      Color(0xFFF08080),
      Color(0xFFE9967A),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _splashCtrl.controller,
            builder: (context, child) {
              return Opacity(
                opacity: _splashCtrl.fade.value,
                child: SlideTransition(
                  position: _splashCtrl.slide,
                  child: ScaleTransition(
                    scale: _splashCtrl.scale,
                    child: child,
                  ),
                ),
              );
            },
            child: Image.asset(
              'assets/mytech.png',
              width: 220,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}