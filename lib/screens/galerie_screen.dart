import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../widgets/livre_card.dart';
import '../widgets/livre_grid_item.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  final List<Livre> livres;
  final VoidCallback? onModifie;

  const GalerieScreen({super.key, required this.livres, this.onModifie});

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  bool _enGrille = true;
  bool _triParNote = false;

  List<Livre> get _livresAffiches {
    final liste = List<Livre>.from(widget.livres);
    if (_triParNote) {
      liste.sort((a, b) => b.note.compareTo(a.note));
    }
    return liste;
  }

  int _nombreColonnes(double largeur) {
    if (largeur < 600) return 2;
    if (largeur < 900) return 3;
    return 4;
  }

  Future<void> _ouvrirDetail(Livre livre) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailScreen(livre: livre, onModifie: widget.onModifie),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final livres = _livresAffiches;
    final largeur = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
        actions: [
          IconButton(
            icon: Icon(_triParNote ? Icons.star : Icons.sort),
            onPressed: () {
              setState(() {
                _triParNote = !_triParNote;
              });
            },
          ),

          IconButton(
            icon: Icon(_enGrille ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _enGrille = !_enGrille;
              });
            },
          ),
        ],
      ),

      body: _enGrille
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _nombreColonnes(largeur),
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: livres.length,
              itemBuilder: (context, index) => LivreGridItem(
                livre: livres[index],
                onTap: () => _ouvrirDetail(livres[index]),
              ),
            )
          : ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) => LivreCard(
                livre: livres[index],
                onTap: () => _ouvrirDetail(livres[index]),
              ),
            ),
    );
  }
}
