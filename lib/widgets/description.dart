import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final String text;
  final Color color;

  const Description({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modo de Preparo:',
          style: TextStyle(
            color: widget.color,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          widget.text,
          style: TextStyle(
            color: widget.color,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
