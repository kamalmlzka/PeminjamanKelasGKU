import "dart:async";

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "/widgets/background_shapes.dart";

import "/services/auth.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 10),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Auth())));
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Peminjaman Kelas GKU",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                Text(
                  "v0.0.1",
                  style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.bold, fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}