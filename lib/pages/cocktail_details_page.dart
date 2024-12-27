import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/repositories/details_repository.dart';
import 'package:thecocktaildb_app/pages/store/details_store.dart';
import 'package:thecocktaildb_app/widgets/custom_app_bar.dart';

class CocktailDetailsPage extends StatefulWidget {
  final String id;
  final String title;

  const CocktailDetailsPage({
    super.key,
    required this.id,
    required this.title,
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
    return Scaffold(
        appBar: CustomAppBar(title: widget.title),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      details.image,
                      width: 300,
                      height: 300,
                    ),
                  ),
                  Text(
                    details.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
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
                        title: Text(ingredient.name),
                        subtitle: Text(ingredient.measure),
                      );
                    },
                  )
                ]),
              ),
            );
          },
        ));
  }
}
