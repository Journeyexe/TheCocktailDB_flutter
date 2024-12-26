import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/repositories/details_repository.dart';
import 'package:thecocktaildb_app/pages/store/details_store.dart';

class CocktailDetailsPage extends StatefulWidget {
  const CocktailDetailsPage({super.key});

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
    store.getDetails('11007');
  }

  @override
  Widget build(BuildContext context) {
    final details = store.state.value;
    // ignore: avoid_print
    print(details);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cocktail Details'),
          centerTitle: true,
        ),
        body: Center(
            child: AnimatedBuilder(
                animation: Listenable.merge([
                  store.isLoading,
                  store.state,
                  store.erro,
                ]),
                builder: (context, child) {
                  if (store.isLoading.value) {
                    return const CircularProgressIndicator();
                  }
                  if (store.erro.value.isNotEmpty) {
                    return Text(store.erro.value);
                  }
                  return Column(
                    children: [
                      const Text('Vai com Deus irmao'),
                      Text(details.toString())
                      // Image.network(details.image),
                      // Text(details.name),
                      // Text(details.description),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: details.ingredients.length,
                      //   itemBuilder: (context, index) {
                      //     final ingredient = details.ingredients[index];
                      //     return ListTile(
                      //       title: Text(ingredient.name),
                      //       subtitle: Text(ingredient.measure),
                      //     );
                      //   },
                      // ),
                    ],
                  );
                }
            )
          )
        );
  }
}
