import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Ingredient extends StatefulWidget {
  final Map item;

  const Ingredient({
    super.key,
    required this.item,
  });

  @override
  State<Ingredient> createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  @override
  Widget build(BuildContext context) {
    HSLColor baseColor =
        HSLColor.fromColor(Color(int.parse(widget.item['color'])));
    Color bgColor = baseColor.withLightness(.9).toColor();
    Color textColor = baseColor.withLightness(.2).toColor();
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: bgColor,
          ),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  widget.item['ingredientPT'],
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ),
            onTap: () => context.push('/list/${widget.item['ingredientEN']}/false'),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
