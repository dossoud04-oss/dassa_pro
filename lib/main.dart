import 'package:flutter/material.dart';
import 'artisan.dart';
import 'database_helper.dart';

void main() {
  runApp(const MonApplication());
}

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dassa Pro',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const EcranAccueil(),
    );
  }
}

class EcranAccueil extends StatefulWidget {
  const EcranAccueil({super.key});

  @override
  State<EcranAccueil> createState() => _EcranAccueilState();
}

class _EcranAccueilState extends State<EcranAccueil> {
  List<Artisan> _artisans = [];

  @override
  void initState() {
    super.initState();
    _chargerArtisans();
  }

  // Lire depuis SQLite
  void _chargerArtisans() async {
    final artisans = await DatabaseHelper.instance.lireArtisans();
    setState(() {
      _artisans = artisans;
    });
  }

  // Ajouter un faux artisan pour le test
  void _ajouterFauxArtisan() async {
    final nouvelArtisan = Artisan(
      nom: 'Jean le Plombier',
      metier: 'Plomberie',
      telephone: '97000000',
      quartier: 'Dassa Centre',
    );
    await DatabaseHelper.instance.ajouterArtisan(nouvelArtisan);
    _chargerArtisans(); // Recharger la liste
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dassa Pro - Test SQLite')),
      body: _artisans.isEmpty
          ? const Center(child: Text('Aucun artisan enregistré.\nAppuyez sur + pour ajouter.'))
          : ListView.builder(
              itemCount: _artisans.length,
              itemBuilder: (context, index) {
                final artisan = _artisans[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(artisan.nom),
                  subtitle: Text('${artisan.metier} - ${artisan.quartier}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.phone, color: Colors.green),
                    onPressed: () {
                      // Ici on mettra la logique d'appel/SMS plus tard
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ajouterFauxArtisan,
        tooltip: 'Ajouter un artisan',
        child: const Icon(Icons.add),
      ),
    );
  }
}
