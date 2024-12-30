import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSearchBar extends StatefulWidget {
  final bool serachByName;

  const CustomSearchBar({
    super.key,
    required this.serachByName,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        onFieldSubmitted: (value) => context.push('/list/$value/${widget.serachByName.toString()}'),
      ),
    );
  }
}
