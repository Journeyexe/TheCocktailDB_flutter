import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  final Color color;

  const PopButton({
    super.key,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: color, // Define a cor personalizada do ícone.
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
