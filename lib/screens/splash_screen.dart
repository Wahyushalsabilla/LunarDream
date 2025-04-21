import 'package:flutter/material.dart';
import 'dart:async';
import '/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    print("SplashScreen - initState called");
    
    // Initialize animation controller with a shorter duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Reduced from 5 to 2 seconds
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    
    // Add a listener to know when animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("SplashScreen - Animation completed");
      }
    });
    
    // Start the animation
    _controller.forward();
    
    // Use WidgetsBinding to ensure the UI is built before starting the timer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("SplashScreen - First frame rendered");
      
      // Use Future.delayed instead of Timer
      Future.delayed(const Duration(seconds: 3), () {
        print("SplashScreen - Delay completed, preparing to navigate");
        if (mounted && !_isNavigating) {
          setState(() {
            _isNavigating = true;
          });
          print("SplashScreen - Navigating to welcome screen");
          Navigator.pushReplacementNamed(context, '/welcome');
        }
      });
    });
  }

  @override
  void dispose() {
    print("SplashScreen - dispose called");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("SplashScreen - build method called");
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D2143), // Dark blue
              Color(0xFF381B58), // Purple
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with fade animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: const LogoWidget(
                  size: 180,
                  showTagline: true,
                ),
              ),
              
              // Add a loading indicator to make it clear the splash screen is active
              const SizedBox(height: 40),
              FadeTransition(
                opacity: _fadeAnimation,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}