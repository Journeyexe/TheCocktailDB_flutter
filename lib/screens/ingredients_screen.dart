import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/widgets/custom_search_bar.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomSearchBar(serachByName: false,)
        ],
      ),
    );
  }
}