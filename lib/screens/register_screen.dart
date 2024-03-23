import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '/widgets/ddm.dart';
import '/widgets/button.dart';
import '/widgets/login_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isRegistered = false;

  void _register() async {
    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      isRegistered = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (context) => const LoginScreen()),
                  (_) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _login() {
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
            controller: nimController,
            obscureText: false,
            label: 'NIM',
            readOnly: false,
          ),
          const SizedBox(height: 10),
          LoginForm(
            controller: passwordController,
            obscureText: true,
            label: 'Password',
            readOnly: false,
          ),
          const SizedBox(height: 10),
          LoginForm(
            controller: confirmPasswordController,
            obscureText: true,
            label: 'Confirm Password',
            readOnly: false,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _login,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
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
          const SizedBox(height: 10),
          Button(
            actionOnButton: _register,
            buttonText: 'Register',
          ),
        ],
      ),
    );
  }
}
