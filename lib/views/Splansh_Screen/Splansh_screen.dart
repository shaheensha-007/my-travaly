import 'package:flutter/material.dart';
import '../../Contollers/SplanshContoller/Splansh_contoller.dart';
import '../Signin-up/Signin-up.dart'; // <-- your real next page

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

    // 1. Create the controller (vsync = this)
    _splashCtrl = SplashController(this);

    // 2. Kick-off animation + navigation
    _splashCtrl.startAndNavigate(context, const GoogleAuthPage());
  }

  @override
  void dispose() {
    _splashCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<Color> gradientColors = [
      Color(0xFF17328D), // Your current blue as the starting color
      Color(0xFFF08080), // A lighter, soft coral/salmon color
      Color(0xFFE9967A) // A darker shade for the end of the gradient
    ];
    return Scaffold(
      // 1. Remove the backgroundColor from Scaffold
      // backgroundColor: const Color(0xFF17328D),

      // 2. Use a Container as the body to hold the gradient
      body: Container(
        // The BoxDecoration is where you apply the gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        // 3. Place your existing content inside the Container's child
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