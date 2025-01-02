import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/services/load_json.dart';
import 'package:thecocktaildb_app/widgets/ingredients_screen/list_ingredients.dart';
import 'package:thecocktaildb_app/widgets/pop_button.dart';

class ListIngredientsScreen extends StatefulWidget {
  const ListIngredientsScreen({super.key});

  @override
  State<ListIngredientsScreen> createState() => _ListIngredientsScreenState();
}

class _ListIngredientsScreenState extends State<ListIngredientsScreen> {
  late ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  late List<Map<String, dynamic>> ingredients = [];
  late List<Map<String, dynamic>> shown = [];

  @override
  void initState() {
    super.initState();
    loadIngredients();
  }

  void setShown(value) {
    setState(() {
      shown = ingredients.where((element) {
        return removeDiacritics(element['ingredientPT'].toLowerCase())
                .contains(value.toLowerCase()) ||
            removeDiacritics(element['ingredientEN'].toLowerCase())
                .contains(value.toLowerCase());
      }).toList();
    });
  }

  Future<void> loadIngredients() async {
    isLoading.value = true;
    ingredients = await loadIngredientsJson();
    shown = List<Map<String, dynamic>>.from(ingredients);
    isLoading.value = false;
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        autocorrect: true,
        decoration: InputDecoration(
          hintText: 'Buscar por ingrediente',
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
        onChanged: (value) => setShown(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: Listenable.merge([isLoading]),
          builder: (context, child) {
            if (isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: statusBarHeight * .6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: screenWidth * .85,
                        child: _searchBar(),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenWidth,
                    child: ListIngredients(
                      ingredients: shown,
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: const PopButton(
        color: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
