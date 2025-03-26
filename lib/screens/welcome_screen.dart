import 'package:flutter/material.dart';
import '../widgets/logo_widget.dart';
import '../theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D2143), 
              Color(0xFF381B58),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Logo at the top
              const LogoWidget(
                size: 150,
                showTagline: false,
              ),
              const SizedBox(height: 40),
              // Welcome text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome to the app to explore your dreams!',
                      textAlign: TextAlign.center,
                      style: AppTheme.headingStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Let us guide you in uncovering the deeper messages and meanings within your dreams',
                      textAlign: TextAlign.center,
                      style: AppTheme.bodyStyle,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Button at the bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 77.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(265, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Let's Dreaming!",
                    style: AppTheme.subheadingStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

