import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/data/repositories/cocktail_repository.dart';
import 'package:thecocktaildb_app/pages/store/cocktail_store.dart';
import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/widgets/custom_app_bar.dart';

class ListPage extends StatefulWidget {
  final String keyWord;

  const ListPage({super.key, required this.keyWord});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final CocktailStore store = CocktailStore(
    repository: CocktailRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    // store.getCocktails('caipirinha');
    store.getCocktails('Martini');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title:  'Cocktails', isHomePage: true,),
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
                        return InkWell(
                          onTap: () => context.push('/details/${cocktail.id}/${cocktail.name}'),
                          child: Column(
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
                          ),
                        );
                      });
                })));
  }
}
