import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSearchBar extends StatefulWidget {
  final bool serachByName;
  final String placeHolder;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    required this.serachByName,
    required this.placeHolder, this.controller,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: widget.placeHolder,
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
            context.push('/list/$value/${widget.serachByName.toString()}'),
      ),
    );
  }
}
