import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF3F0FF),
              Colors.white,
              Color(0xFFEDEAFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie Animation
              Lottie.asset(
                'assets/notes.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 15),

              // MyNotes Title
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'My',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Notes',
                      style: TextStyle(
                        color: Color(0xFF4938F5),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Tagline
              const Text(
                'Capture Ideas',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF444444),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Organize Your Thoughts',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF444444),
                ),
              ),

              const SizedBox(height: 50),

              // Loading Indicator
              const SizedBox(
                width: 35,
                height: 35,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF4938F5),
                  ),
                ),
              ),

              const SizedBox(height: 65),

              // Bottom Progress Bar
              Container(
                width: 130,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFDAD4FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 65,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4938F5),
                      borderRadius: BorderRadius.circular(10),
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
