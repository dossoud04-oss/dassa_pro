class Artisan {
  final int? id;
  final String nom;
  final String metier;
  final String telephone;
  final String quartier;

  Artisan({
    this.id,
    required this.nom,
    required this.metier,
    required this.telephone,
    required this.quartier,
  });

  // Pour envoyer les données vers SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'metier': metier,
      'telephone': telephone,
      'quartier': quartier,
    };
  }

  // Pour lire les données depuis SQLite
  factory Artisan.fromMap(Map<String, dynamic> map) {
    return Artisan(
      id: map['id'],
      nom: map['nom'],
      metier: map['metier'],
      telephone: map['telephone'],
      quartier: map['quartier'],
    );
  }
}
