import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isHomePage;
  const CustomAppBar({
    super.key,
    this.title = '',
    this.isHomePage = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: (title != '')
          ? Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            )
          : null,
      centerTitle: true,
      leading: isHomePage
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black, // Define a cor personalizada do ícone.
              onPressed: () {
                Navigator.pop(context);
              },
            ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(56);
  }
}
