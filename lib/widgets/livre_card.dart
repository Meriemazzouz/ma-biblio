import 'package:flutter/material.dart';
import '../models/livre.dart';

Widget livreTile(Livre livre) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(
        livre.titre[0],
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),

    title: Text(livre.titre),

    subtitle: Text('${livre.auteur} – ${livre.annee}'),

    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${livre.note}'),
        const Icon(Icons.star, color: Colors.amber),
      ],
    ),
  );
}