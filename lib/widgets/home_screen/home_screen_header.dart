import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/widgets/custom_search_bar.dart';

class HomeScreenHeader extends StatefulWidget {
  const HomeScreenHeader({super.key});

  @override
  State<HomeScreenHeader> createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 60,
        ),
        SizedBox(
          child: Column(
            children: [
              Padding(
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
              CustomSearchBar(serachByName: true)
            ],
          ),
        ),
      ],
    );
  }
}