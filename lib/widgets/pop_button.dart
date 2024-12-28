import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.white, // Define a cor personalizada do ícone.
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
