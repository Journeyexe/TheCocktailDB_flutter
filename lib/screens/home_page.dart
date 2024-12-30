import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/services/load_json.dart';
import 'package:thecocktaildb_app/widgets/custom_app_bar.dart';

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
    print(randomIngredients);
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              Text(
                                'Drink Master',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Buscar por drinks',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(.5),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onFieldSubmitted: (value) =>
                                context.push('/list/$value/true'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenWidth,
                          height: 400,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 30),
                            itemCount: randomIngredients.length,
                            itemBuilder: (_, index) {
                              final item = randomIngredients[index];
                              return ListTile(
                                title: Text(item['ingredientPT']),
                                onTap: () => context.push('/list/${item['ingredientEN']}/false'),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                  // ElevatedButton(
                  //   onPressed: () => context.push('/list/Martini'),
                  //   child: const Text('testa ae pae'),
                  // ),
                ],
              );
            }
          }),
    );
  }
}
