import 'package:flutter/material.dart';

class CocktailTitle extends StatefulWidget {
  final String title;
  final String category;
  final bool isAlcoholic;
  final double screenWidth;
  final Color textColor;

  const CocktailTitle({
    super.key,
    required this.title,
    required this.category,
    required this.isAlcoholic,
    required this.screenWidth,
    required this.textColor,
  });

  @override
  State<CocktailTitle> createState() => _CocktailTitleState();
}

class _CocktailTitleState extends State<CocktailTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: (widget.screenWidth / 3 * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.category.toLowerCase(),
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                widget.isAlcoholic ? Icons.local_bar : Icons.coffee,
                color: widget.textColor,
              ),
              Text(
                widget.isAlcoholic ? 'Alcoólico' : 'Sem Álcool',
                style: TextStyle(
                    color: widget.textColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
