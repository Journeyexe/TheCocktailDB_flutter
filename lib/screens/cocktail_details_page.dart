import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/repositories/details_repository.dart';
import 'package:thecocktaildb_app/screens/store/details_store.dart';
import 'package:thecocktaildb_app/widgets/pop_button.dart';

class CocktailDetailsPage extends StatefulWidget {
  final String id;

  const CocktailDetailsPage({
    super.key,
    required this.id,
  });

  @override
  State<CocktailDetailsPage> createState() => _CocktailDetailsPageState();
}

class _CocktailDetailsPageState extends State<CocktailDetailsPage> {
  HSLColor? baseColor;
  final DetailsStore store = DetailsStore(
    repository: DetailsRepository(
      client: HttpClient(),
    ),
  );

  Future<void> _getColor(imageUrl) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),
    );

    if (mounted) {
      setState(() {
        baseColor = HSLColor.fromColor(
            paletteGenerator.dominantColor?.color ?? Colors.white);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    store.state.addListener(() {});
    store.getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.state,
          store.erro,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (store.erro.value.isNotEmpty) {
            return Text(store.erro.value);
          }
          final details = store.state.value[0];
          _getColor(details.image);
          final textColor =
              baseColor?.withLightness(.2).toColor() ?? Colors.black;
          final backGroundColor =
              baseColor?.withLightness(.9).toColor() ?? Colors.white;
          return SingleChildScrollView(
            child: Column(children: [
              Image.network(
                details.image,
                width: imageSize,
                height: imageSize,
              ),
              Transform.translate(
                offset: const Offset(0, -30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: (imageSize / 3 * 2),
                            child: Text(
                              details.name,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Text('Ingredientes:',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: details.ingredients.length,
                            itemBuilder: (context, index) {
                              final ingredient = details.ingredients[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: backGroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            'https://www.thecocktaildb.com/images/ingredients/${ingredient.name}.png',
                                            width: 50,
                                            height: 50,
                                          ),
                                          Text(
                                            ingredient.name,
                                            style: TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            ingredient.measure,
                                            style: TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Text(
                          details.description,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
      floatingActionButton: const PopButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
