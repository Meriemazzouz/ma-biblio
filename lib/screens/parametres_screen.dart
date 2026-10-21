import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  final Future<void> Function()? onReinitialiser;

  const ParametresScreen({super.key, this.onReinitialiser});

  Future<void> _confirmer(BuildContext context) async {
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réinitialiser ma bibliothèque ?'),
        content: const Text('Les livres lus et les favoris seront effacés.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Réinitialiser'),
          ),
        ],
      ),
    );

    if (confirme == true) {
      await onReinitialiser?.call();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bibliothèque réinitialisée')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mon profil'),
              subtitle: const Text('Nom, e-mail, mot de passe'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil sélectionné')),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              tileColor: Colors.indigo.shade50,
              iconColor: Colors.indigo,
              textColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Langue'),
              subtitle: const Text('Français'),
            ),

            ListTile(
              leading: const Icon(Icons.restart_alt),
              title: const Text('Réinitialiser ma bibliothèque'),
              onTap: () => _confirmer(context),
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              subtitle: const Text(
                'MaBiblio version 1.0\nTP Listes et grilles avec Flutter',
              ),
              dense: true,
              isThreeLine: true,
            ),
          ],
        ).toList(),
      ),
    );
  }
}
