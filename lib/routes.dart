import 'package:go_router/go_router.dart';
import 'package:thecocktaildb_app/pages/cocktail_details_page.dart';
import 'package:thecocktaildb_app/pages/list_page.dart.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const ListPage(keyWord: 'Martini'),
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
