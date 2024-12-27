import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/screens/cocktail_details_page.dart';
import 'package:thecocktaildb_app/screens/home_page.dart';
import 'package:thecocktaildb_app/screens/list_page.dart.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/list/:keyWord',
    builder: (context, state) {
      final keyWord = state.pathParameters['keyWord']!;
      return ListPage(keyWord: keyWord);
    },
  ),
  GoRoute(
    path: '/details/:id/:title',
    builder: (context, state) {
      final id = state.pathParameters['id'];
      final title = state.pathParameters['title'];
      return CocktailDetailsPage(id: id!, title: title!);
    },
  )
]);
