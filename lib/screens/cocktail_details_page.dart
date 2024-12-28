import 'package:flutter/material.dart';
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
  final DetailsStore store = DetailsStore(
    repository: DetailsRepository(
      client: HttpClient(),
    ),
  );

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
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          details.description,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: details.ingredients.length,
                          itemBuilder: (context, index) {
                            final ingredient = details.ingredients[index];
                            return ListTile(
                              leading: Image.network(
                                'https://www.thecocktaildb.com/images/ingredients/${ingredient.name}.png',
                                width: 50,
                                height: 50,
                              ),
                              title: Text(ingredient.name),
                              subtitle: Text(ingredient.measure),
                            );
                          },
                        )
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
