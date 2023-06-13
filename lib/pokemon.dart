class Pokemon {
  final String name;
  final int hp;
  final int experience;
  final int attack;
  final int specialAttack;
  final int defense;
  final String imageUrl;

  Pokemon({
    required this.name,
    required this.hp,
    required this.experience,
    required this.attack,
    required this.specialAttack,
    required this.defense,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'];
    return Pokemon(
      name: json['name'],
      hp: json['stats'][0]['base_stat'],
      experience: json['base_experience'],
      attack: json['stats'][1]['base_stat'],
      specialAttack: json['stats'][3]['base_stat'],
      defense: json['stats'][2]['base_stat'],
      imageUrl: sprites['other']['official-artwork']['front_default'],
    );
  }
}
