import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/data/repositories/cocktail_repository.dart';
import 'package:thecocktaildb_app/screens/store/cocktail_store.dart';
import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/widgets/custom_app_bar.dart';
import 'package:thecocktaildb_app/widgets/list_screen/list_drinks.dart';

class ListScreen extends StatefulWidget {
  final String keyWord;
  final bool searchByName;

  const ListScreen({
    super.key,
    required this.keyWord,
    required this.searchByName,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final CocktailStore store = CocktailStore(
    repository: CocktailRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getCocktails(widget.keyWord, widget.searchByName);
    // store.getCocktails('Martini');
  }

  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
    final keyWord = widget.keyWord;
    return Scaffold(
      appBar: CustomAppBar(title: 'Busca por $keyWord'),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge(
            [
              store.isLoading,
              store.state,
              store.erro,
            ],
          ),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const CircularProgressIndicator();
            }
            if (store.erro.value.isNotEmpty) {
              return Text(store.erro.value);
            }

            return ListDrinks(drinks: store.state.value, width: screenWidth,);
          },
        ),
      ),
    );
  }
}
