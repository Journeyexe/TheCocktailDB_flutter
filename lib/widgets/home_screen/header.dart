import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        SizedBox(
          child: Column(
            children: [
              const Padding(
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
              Padding(
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
                  onFieldSubmitted: (value) =>
                      context.push('/list/$value/true'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
