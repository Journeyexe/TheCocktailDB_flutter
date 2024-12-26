import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/data/repositories/cocktail_repository.dart';
import 'package:thecocktaildb_app/pages/store/cocktail_store.dart';
import 'package:thecocktaildb_app/data/http/http_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CocktailStore store = CocktailStore(
    repository: CocktailRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getCocktails('pina');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const Text('Home Page', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),),
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

                  return ListView.builder(
                      itemCount: store.state.value.length,
                      itemBuilder: (context, index) {
                        final cocktail = store.state.value[index];
                        return Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                cocktail.image,
                                width: 300,
                                height: 300,
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Center(
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
                        );
                      });
                })));
  }
}
