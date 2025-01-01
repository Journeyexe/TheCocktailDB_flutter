import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/screens/cocktail_details_screen.dart';
import 'package:thecocktaildb_app/screens/home_screen.dart';
import 'package:thecocktaildb_app/screens/ingredient_details_screen.dart';
import 'package:thecocktaildb_app/screens/list_ingredients_screen.dart';
import 'package:thecocktaildb_app/screens/list_screen.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/list/:keyWord/:search',
      builder: (context, state) {
        final keyWord = state.pathParameters['keyWord']!;
        final search = state.pathParameters['search'] ?? 'false';
        return ListScreen(
          keyWord: keyWord,
          searchByName: (search == 'true'),
        );
      },
    ),
    GoRoute(
      path: '/details/cocktail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return CocktailDetailsScreen(id: id!);
      },
    ),
    GoRoute(
      path: '/details/ingredient/:name',
      builder: (context, state) {
        final name = state.pathParameters['name'];
        return IngredientsDetailsScreen(name: name!);
      },
    ),
    GoRoute(
      path: '/ingredients',
      builder: (context, state) => const ListIngredientsScreen(),
    ),
  ],
);
