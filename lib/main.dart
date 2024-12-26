import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/pages/cocktail_details_page.dart';
import 'package:thecocktaildb_app/pages/list_page.dart.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const ListPage(
              keyWord: 'Martini',
            ),
        '/details': (context) => const CocktailDetailsPage(),
      },
    );
  }
}
