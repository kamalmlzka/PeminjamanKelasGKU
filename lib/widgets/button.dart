import "package:flutter/material.dart";

class Button extends StatelessWidget {
  final Function() actionOnButton;
  final String buttonText;

  const Button(
      {super.key, required this.actionOnButton, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ElevatedButton(
        onPressed: actionOnButton,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: const Color.fromARGB(255, 131, 22, 22),
        ),
        child: Text(
          buttonText.toUpperCase(),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
