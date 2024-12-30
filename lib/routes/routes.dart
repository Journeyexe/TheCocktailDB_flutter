import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/screens/cocktail_details_page.dart';
import 'package:thecocktaildb_app/screens/home_page.dart';
import 'package:thecocktaildb_app/screens/list_page.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/list/:keyWord/:search',
      builder: (context, state) {
        final keyWord = state.pathParameters['keyWord']!;
        final search = state.pathParameters['search'] ?? 'false';
        return ListPage(
          keyWord: keyWord,
          searchByName: (search == 'true'),
        );
      },
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return CocktailDetailsPage(id: id!);
      },
    )
  ],
);
