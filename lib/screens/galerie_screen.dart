import 'package:flutter/material.dart';
import '../models/livre.dart';

class GalerieScreen extends StatelessWidget {
  final List<Livre> livres;

  const GalerieScreen({super.key, required this.livres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galerie')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
        children: List.generate(
          6,
          (i) => Container(
            color: Colors.primaries[i],
            alignment: Alignment.center,
            child: Text(
              '${i + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}