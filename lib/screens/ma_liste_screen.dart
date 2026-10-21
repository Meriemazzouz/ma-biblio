import 'package:flutter/material.dart';
import '../models/livre.dart';

class MaListeScreen extends StatefulWidget {
  final List<Livre> livres;
  final VoidCallback? onModifie;

  const MaListeScreen({super.key, required this.livres, this.onModifie});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;

  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  final Map<String, IconData> _icones = {
    'Roman': Icons.auto_stories,
    'Science': Icons.science,
    'Histoire': Icons.account_balance,
    'Jeunesse': Icons.child_care,
    'Informatique': Icons.computer,
  };

  final Map<String, Color> _couleurs = {
    'Roman': Colors.pink,
    'Science': Colors.indigo,
    'Histoire': Colors.brown,
    'Jeunesse': Colors.blue,
    'Informatique': Colors.green,
  };

  bool? get _tousLesGenres {
    if (_genres.values.every((coche) => coche)) return true;
    if (_genres.values.every((coche) => !coche)) return false;
    return null;
  }

  int _nombreLivres(String genre) {
    return widget.livres.where((livre) => livre.genre == genre).length;
  }

  List<Livre> get _livresAffiches {
    return widget.livres
        .where((livre) => _genres[livre.genre] == true)
        .where((livre) => !_nouveautesSeulement || livre.nouveaute)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final affiches = _livresAffiches;
    final nombreLus = affiches.where((livre) => livre.lu).length;

    return Scaffold(
      appBar: AppBar(title: Text('Lus : $nombreLus / ${affiches.length}')),
      body: Column(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (valeur) {
              setState(() {
                _nouveautesSeulement = valeur ?? false;
              });
            },
          ),

          const Divider(height: 1),

          CheckboxListTile(
            title: const Text(
              'Tous les genres',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            tristate: true,
            value: _tousLesGenres,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (valeur) {
              final toutEstCoche = _tousLesGenres == true;
              setState(() {
                _genres.updateAll((genre, coche) => !toutEstCoche);
              });
            },
          ),

          ..._genres.keys.map(
            (genre) => CheckboxListTile(
              title: Text(genre),
              subtitle: Text('${_nombreLivres(genre)} livre(s)'),
              secondary: Icon(_icones[genre], color: _couleurs[genre]),
              activeColor: _couleurs[genre],
              value: _genres[genre],
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (valeur) {
                setState(() {
                  _genres[genre] = valeur ?? false;
                });
              },
            ),
          ),

          const Divider(thickness: 2),

          Expanded(
            child: ListView.separated(
              itemCount: affiches.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final livre = affiches[index];
                return CheckboxListTile(
                  value: livre.lu,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      decoration: livre.lu ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text('${livre.auteur} – ${livre.genre}'),
                  onChanged: (valeur) {
                    setState(() {
                      livre.lu = valeur ?? false;
                    });
                    widget.onModifie?.call();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
