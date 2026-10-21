import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class CatalogueScreen extends StatefulWidget {
  final List<Livre> livres;
  final VoidCallback? onModifie;

  const CatalogueScreen({super.key, required this.livres, this.onModifie});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  Future<void> _ouvrirDetail(Livre livre) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(livre: livre, onModifie: widget.onModifie),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final livres = widget.livres;
    final nouveautes = livres.where((livre) => livre.nouveaute).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Nouveautés',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: nouveautes.length,
            itemBuilder: (context, index) {
              final livre = nouveautes[index];
              return GestureDetector(
                onTap: () => _ouvrirDetail(livre),
                child: Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: livre.couleur,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Tous les livres',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: livres.length,
            itemBuilder: (context, index) => LivreCard(
              livre: livres[index],
              onTap: () => _ouvrirDetail(livres[index]),
            ),
          ),
        ),
      ],
    );
  }
}