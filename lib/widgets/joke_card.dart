import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String type;
  final VoidCallback onTap;

  const JokeCard({Key? key, required this.type, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          type.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}
