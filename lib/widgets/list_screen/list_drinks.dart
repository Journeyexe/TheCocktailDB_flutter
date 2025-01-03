import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/data/models/cocktail_model.dart';

class ListDrinks extends StatefulWidget {
  final List<CocktailModel> drinks;
  final double width;

  const ListDrinks({
    super.key,
    required this.drinks,
    required this.width,
  });

  @override
  State<ListDrinks> createState() => _ListDrinksState();
}

class _ListDrinksState extends State<ListDrinks> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 30,
        ),
        itemCount: widget.drinks.length,
        itemBuilder: (context, index) {
          final cocktail = widget.drinks[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () => context.push('/details/cocktail/${cocktail.id}'),
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    height: 60,
                    imageUrl: cocktail.image,
                    placeholder: (context, url) => const SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: widget.width * .75,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                        cocktail.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
