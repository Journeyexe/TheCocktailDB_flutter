import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/services/load_json.dart';
import 'package:thecocktaildb_app/widgets/home_screen/header.dart';
import 'package:thecocktaildb_app/widgets/home_screen/highlight_ingredients.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> randomIngredients = [];
  late ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    loadRandom();
  }

  Future<void> loadRandom() async {
    isLoading.value = true;
    randomIngredients = await loadRandomIngredients();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedBuilder(
          animation: Listenable.merge([isLoading]),
          builder: (context, child) {
            if (isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  const Header(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: loadRandom,
                              icon: const Icon(Icons.refresh),
                              color: Colors.black,
                            ),
                            RandomIngredients(
                              width: screenWidth,
                              ingredients: randomIngredients,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward))
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/list/vodka/false'),
                    child: const Text('vodka'),
                  ),
                ],
              );
            }
          }),
    );
  }
}
