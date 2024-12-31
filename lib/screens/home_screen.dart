import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/services/load_json.dart';
import 'package:thecocktaildb_app/widgets/home_screen/home_screen_header.dart';
import 'package:thecocktaildb_app/widgets/home_screen/random_ingredients.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            if (isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  const HomeScreenHeader(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // IconButton(
                            //   onPressed: loadRandom,
                            //   icon: const Icon(Icons.refresh),
                            //   color: Colors.black,
                            // ),
                            RandomIngredients(
                              width: screenWidth,
                              ingredients: randomIngredients,
                            ),
                            IconButton(
                                onPressed: () => context.push('/ingredients'),
                                icon: const Icon(Icons.arrow_forward))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
