import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/data/models/details_model.dart';

class IngredientsList extends StatefulWidget {
  final List<IngredientsModel> ingredients;
  final Color backGroundColor;
  final Color textColor;

  const IngredientsList({
    super.key,
    required this.ingredients,
    required this.backGroundColor,
    required this.textColor,
  });

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredientes:',
          style: TextStyle(
            color: widget.textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.ingredients.length,
            itemBuilder: (context, index) {
              final ingredient = widget.ingredients[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.backGroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: InkWell(
                      onTap: () => context.push('/details/ingredient/${ingredient.name}'),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://www.thecocktaildb.com/images/ingredients/${ingredient.name}-Small.png',
                              width: 50,
                              height: 50,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Text(
                              ingredient.name,
                              style: TextStyle(
                                color: widget.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            ingredient.measure.isNotEmpty
                                ? Text(
                                    ingredient.measure,
                                    style: TextStyle(
                                      color: widget.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
