// import "dart:developer" as dev;
// import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../widgets/ddm.dart';
import '../widgets/button.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _loginFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;

  void _login() async {
    Navigator.of(context).pop();
    // if (_loginFormKey.currentState != null &&
    //     _loginFormKey.currentState!.validate()) {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    //   try {
    //     await FirebaseAuth.instance.signInWithEmailAndPassword(
    //         email: usernameController.text, password: passwordController.text);
    //     // ignore: use_build_context_synchronously
    //     Navigator.pop(context);
    //   } on FirebaseAuthException catch (e) {
    //     // ignore: use_build_context_synchronously
    //     Navigator.pop(context);
    //     if (e.code == 'user-not-found') {
    //       dev.log("Wrong Mail", name: "Error");
    //     } else if (e.code == 'wrong-password') {
    //       dev.log("Wrong Password", name: "Error");
    //     }
    //   }
    // }
  }

  void register() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Login',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            isLoggedIn ? 'Login Successful!' : 'Welcome',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          LoginForm(
            controller: usernameController,
            label: "Username",
            readOnly: false,
            obscureText: false,
          ),
          const SizedBox(height: 10),
          LoginForm(
            controller: passwordController,
            label: "Password",
            readOnly: false,
            obscureText: true,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: register,
            child: const Padding(
              padding: /**/ EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Button(actionOnButton: _login, buttonText: "Login")
        ],
      ),
    );
  }
}
