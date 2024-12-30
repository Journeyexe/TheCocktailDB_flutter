import 'package:flutter/material.dart';

class CustomDivider extends StatefulWidget {
  final Color color;
  const CustomDivider({
    super.key,
    required this.color,
  });

  @override
  State<CustomDivider> createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: widget.color,
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
