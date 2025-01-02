import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/models/ingredient_model.dart';
import 'package:thecocktaildb_app/data/repositories/ingredient_repository.dart';
import 'package:thecocktaildb_app/screens/store/ingredient_store.dart';
import 'package:thecocktaildb_app/widgets/custom_divider.dart';
import 'package:thecocktaildb_app/widgets/pop_button.dart';

class IngredientsDetailsScreen extends StatefulWidget {
  final String name;

  const IngredientsDetailsScreen({
    super.key,
    required this.name,
  });

  @override
  State<IngredientsDetailsScreen> createState() =>
      _IngredientsDetailsScreenState();
}

class _IngredientsDetailsScreenState extends State<IngredientsDetailsScreen> {
  Color textColor = Colors.black;
  Color backGroundColor = Colors.white;
  HSLColor? baseColor;
  final IngredientStore store = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  Future<void> _getColor(imageUrl) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(imageUrl),
    );

    if (mounted) {
      setState(() {
        baseColor = HSLColor.fromColor(
            paletteGenerator.dominantColor?.color ?? Colors.white);
        textColor = baseColor?.withLightness(.2).toColor() ?? Colors.black;
        backGroundColor =
            baseColor?.withLightness(.9).toColor() ?? Colors.white;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    store.state.addListener(() {
      if (store.state.value.isNotEmpty) {
        _getColor(
            'https://www.thecocktaildb.com/images/ingredients/${store.state.value[0].name}.png');
      }
    });
    store.getIngredient(widget.name);
  }

  @override
  void dispose() {
    store.state.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.name),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: ValueListenableBuilder(
        valueListenable: store.state,
        builder: (context, List<IngredientModel> ingredientList, _) {
          if (store.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (store.erro.value.isNotEmpty) {
            return Text(store.erro.value);
          }
          final ingredient = ingredientList[0];
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  color: backGroundColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: statusBarHeight,
                      ),
                      SizedBox(
                        height: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://www.thecocktaildb.com/images/ingredients/${ingredient.name}.png',
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 80,
                            ),
                            SizedBox(
                              width: screenWidth * .4,
                              child: Column(
                                children: [
                                  Text(
                                    ingredient.translatedName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ingredient.type != 'null'
                                      ? Text(
                                          ingredient.type,
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Column(
                                children: [
                                  Icon(
                                    ingredient.isAlcoholic
                                        ? Icons.local_bar
                                        : Icons.coffee,
                                    color: textColor,
                                  ),
                                  Text(
                                    ingredient.isAlcoholic
                                        ? 'Alcoólico'
                                        : 'Sem Álcool',
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomDivider(
                        color: backGroundColor,
                      ),
                      ingredient.description != 'null'
                          ? Text(
                              ingredient.description,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: PopButton(
        color: textColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
