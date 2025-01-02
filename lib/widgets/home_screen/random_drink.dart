import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:thecocktaildb_app/data/models/details_model.dart';
import 'package:thecocktaildb_app/data/repositories/details_repository.dart';
import 'package:thecocktaildb_app/screens/store/details_store.dart';
import 'package:thecocktaildb_app/widgets/details_screen/title.dart';

import '../../data/http/http_client.dart';

class RandomDrink extends StatefulWidget {
  const RandomDrink({super.key});

  @override
  State<RandomDrink> createState() => _RandomDrinkState();
}

class _RandomDrinkState extends State<RandomDrink> {
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
    store.getDetails('', random: true);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: store.state,
        builder: (context, List<DetailsModel> detailsList, _) {
          if (store.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(store.erro.value),
            );
          }
          final details = detailsList[0];
          return InkWell(
            onTap: () => context.push('/details/cocktail/${details.id}'),
            child: Container(
              decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: CachedNetworkImage(
                      imageUrl: details.image,
                      width: screenWidth,
                      height: screenWidth,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CocktailTitle(
                      title: details.name,
                      category: details.category,
                      isAlcoholic: details.isAlcoholic,
                      screenWidth: screenWidth,
                      textColor: textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
