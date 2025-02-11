import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'onBoarding/screens/onBoarding.dart'; // Import the onboarding screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 10), () {}); // Adjust the delay as needed
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/space.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content Overlay
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  'Karibu',
                  style: GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.w700, color: Colors.greenAccent[400]),
                ),
                SizedBox(height: 20),
                Lottie.asset(

                  'assets/Animation - 1718801216700.json',
                  height: 200,
                  width: 300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
