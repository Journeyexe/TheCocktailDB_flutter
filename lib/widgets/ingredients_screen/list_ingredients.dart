import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/widgets/home_screen/ingredient.dart';

class ListIngredients extends StatefulWidget {
  final List ingredients;

  const ListIngredients({
    super.key,
    required this.ingredients,
  });

  @override
  State<ListIngredients> createState() => _ListIngredientsState();
}

class _ListIngredientsState extends State<ListIngredients> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * .85, // Define a altura do espaço rolável
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.0,
            runSpacing: 12.0,
            children: widget.ingredients.map((ingredient) {
              return Ingredient(item: ingredient); // Sem largura fixa
            }).toList(),
          ),
        ),
      ),
    );
  }
}
