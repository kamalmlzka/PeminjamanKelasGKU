// ignore_for_file: use_build_context_synchronously

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:peminjaman_kelas_gku/widgets/ddm.dart";
import "forget_password_screen.dart";

import "/widgets/button.dart";
import "/widgets/login_form.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  void _login() async {
    if (_loginFormKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userName.text.trim(), password: password.text);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e.code.toString());
        }
        Navigator.pop(context);
        if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Invalid Email")));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Check your Credentials")));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  void forgetPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Login',
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello,",
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                            ),
                          ),
                          Text(
                            "Welcome Back!",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    LoginForm(
                      controller: userName,
                      label: "Email",
                      readOnly: false,
                      obscureText: false,
                    ),
                    const SizedBox(height: 10.0),
                    LoginForm(
                      controller: password,
                      label: "Password",
                      readOnly: false,
                      obscureText: true,
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: forgetPassword,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forget Password?",
                              style: GoogleFonts.firaSans(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Button(
                      actionOnButton: _login,
                      buttonText: "Login",
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
