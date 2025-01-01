import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/models/details_model.dart';
import 'package:thecocktaildb_app/data/repositories/details_repository.dart';
import 'package:thecocktaildb_app/screens/store/details_store.dart';
import 'package:thecocktaildb_app/widgets/details_screen/title.dart';
import 'package:thecocktaildb_app/widgets/custom_divider.dart';
import 'package:thecocktaildb_app/widgets/details_screen/description.dart';
import 'package:thecocktaildb_app/widgets/details_screen/ingredients_list.dart';
import 'package:thecocktaildb_app/widgets/pop_button.dart';

class CocktailDetailsScreen extends StatefulWidget {
  final String id;

  const CocktailDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<CocktailDetailsScreen> createState() => _CocktailDetailsScreenState();
}

class _CocktailDetailsScreenState extends State<CocktailDetailsScreen> {
  Color textColor = Colors.black;
  Color backGroundColor = Colors.white;
  HSLColor? baseColor;
  final DetailsStore store = DetailsStore(
    repository: DetailsRepository(
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
        _getColor(store.state.value[0].image);
      }
    });
    store.getDetails(widget.id);
  }

  @override
  void dispose() {
    store.state.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: store.state,
        builder: (context, List<DetailsModel> detailsList, _) {
          if (store.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (store.erro.value.isNotEmpty) {
            return Text(store.erro.value);
          }
          final details = detailsList[0];
          return SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: details.image,
                  width: screenWidth,
                  height: screenWidth,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CocktailTitle(
                            title: details.name,
                            category: details.category,
                            isAlcoholic: details.isAlcoholic,
                            screenWidth: screenWidth,
                            textColor: textColor,
                          ),
                          CustomDivider(color: backGroundColor),
                          IngredientsList(
                            ingredients: details.ingredients,
                            backGroundColor: backGroundColor,
                            textColor: textColor,
                          ),
                          CustomDivider(color: backGroundColor),
                          Description(
                            text: details.description,
                            color: textColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: const PopButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
