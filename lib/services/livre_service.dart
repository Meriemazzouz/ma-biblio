import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/livre.dart';

class LivreService {
  static Future<File> _fichierLocal() async {
    final dossier = await getApplicationDocumentsDirectory();
    return File('${dossier.path}/mabiblio.json');
  }

  static Future<List<Livre>> chargerLivres() async {
    String contenu;

    if (!kIsWeb && await (await _fichierLocal()).exists()) {
      contenu = await (await _fichierLocal()).readAsString();
    } else {
      contenu = await rootBundle.loadString('assets/livres.json');
    }

    final List<dynamic> donnees = jsonDecode(contenu);
    return donnees
        .map((e) => Livre.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> sauvegarderLivres(List<Livre> livres) async {
    if (kIsWeb) return;
    final fichier = await _fichierLocal();
    await fichier.writeAsString(
      jsonEncode(livres.map((l) => l.toJson()).toList()),
    );
  }

  static Future<void> reinitialiser() async {
    if (kIsWeb) return;
    final fichier = await _fichierLocal();
    if (await fichier.exists()) {
      await fichier.delete();
    }
  }
}
