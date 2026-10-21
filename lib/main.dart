import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'screens/catalogue_screen.dart';
import 'screens/galerie_screen.dart';
import 'screens/ma_liste_screen.dart';
import 'screens/parametres_screen.dart';
import 'services/livre_service.dart';

void main() => runApp(const MaBiblioApp());

class MaBiblioApp extends StatelessWidget {
  const MaBiblioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Livre>> _futureLivres;
  List<Livre> _livres = [];

  @override
  void initState() {
    super.initState();
    _futureLivres = LivreService.chargerLivres();
  }

  void _sauvegarder() {
    LivreService.sauvegarderLivres(_livres);
  }

  Future<void> _reinitialiser() async {
    await LivreService.reinitialiser();
    setState(() {
      _futureLivres = LivreService.chargerLivres();
    });
  }

  Future<void> _ouvrir(Widget ecran) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ecran),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () => _ouvrir(
              GalerieScreen(livres: _livres, onModifie: _sauvegarder),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: () => _ouvrir(
              MaListeScreen(livres: _livres, onModifie: _sauvegarder),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                _ouvrir(ParametresScreen(onReinitialiser: _reinitialiser)),
          ),
        ],
      ),

      body: FutureBuilder<List<Livre>>(
        future: _futureLivres,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erreur : ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          _livres = snapshot.data!;
          return CatalogueScreen(livres: _livres, onModifie: _sauvegarder);
        },
      ),
    );
  }
}
