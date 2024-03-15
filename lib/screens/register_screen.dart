import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../widgets/ddm.dart';
import '../widgets/button.dart';
import '../widgets/login_form.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRegistered = false;

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  void _register() async {
    Navigator.of(context).pop();
    // try {
    //   UserCredential userCredential =
    //       await _auth.createUserWithEmailAndPassword(
    //     email: usernameController.text,
    //     password: passwordController.text,
    //   );
    //   // Registration successful, you can handle the user or navigate to another screen.
    //   print('User registered: ${userCredential.user?.email}');
    // } on FirebaseAuthException catch (e) {
    //   print('Error during registration: ${e.message}');
    // }
  }

  void login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Register',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            isRegistered ? 'Registered' : 'Sign Up',
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
            obscureText: true,
            label: 'Password',
            readOnly: false,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: login,
            child: const Padding(
              padding: /**/ EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Button(
            actionOnButton: _register,
            buttonText: 'Register',
          ),
        ],
      ),
    );
  }
}