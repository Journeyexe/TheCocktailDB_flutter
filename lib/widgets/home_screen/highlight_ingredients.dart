import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/widgets/home_screen/ingredient.dart';

class RandomIngredients extends StatefulWidget {
  final double width;
  final List ingredients;

  const RandomIngredients({
    super.key,
    required this.width,
    required this.ingredients,
  });

  @override
  State<RandomIngredients> createState() => _RandomIngredientsState();
}

class _RandomIngredientsState extends State<RandomIngredients> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * .7,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.ingredients.length,
        itemBuilder: (_, index) {
          final item = widget.ingredients[index];
          return Ingredient(item: item);
        },
      ),
    );
  }
}
