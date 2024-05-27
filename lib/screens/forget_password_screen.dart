// ignore_for_file: use_build_context_synchronously

import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as dev;
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "/widgets/ddm.dart";
import "/screens/login_screen.dart";

import "/widgets/button.dart";
import "/widgets/login_form.dart";

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  final _forgetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController mail = TextEditingController();

  void _sendMail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mail.text);
      dev.log("Mail Sent", name: "Success");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Mail Sent")));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-email'){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid Email")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Pulihkan Password',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Form(
              key: _forgetPasswordFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lupa Password?",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  LoginForm(
                    controller: mail,
                    label: "Email",
                    readOnly: false,
                    obscureText: false, isPassword: true,
                  ),
                  const SizedBox(height: 10.0),
                  Button(
                    actionOnButton: _sendMail,
                    buttonText: "Reset Password",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}