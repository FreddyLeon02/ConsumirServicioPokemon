import 'dart:async';
import 'dart:convert';
import 'package:consumirapi/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<Pokemon> pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = fetchRandomPokemon();
  }

  Future<Pokemon> fetchRandomPokemon() async {
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon/${Random().nextInt(898) + 1}'));
    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }

  void refreshPokemon() {
    setState(() {
      pokemon = fetchRandomPokemon();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon API'),
      ),
      body: Center(
        child: FutureBuilder<Pokemon>(
          future: pokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(snapshot.data!.imageUrl),
                  SizedBox(height: 20),
                  Text(
                    'Name: ${snapshot.data!.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${snapshot.data!.hp} hp',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${snapshot.data!.experience} exp',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Attack: ${snapshot.data!.attack}k',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Special Attack: ${snapshot.data!.specialAttack}k',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Defense: ${snapshot.data!.defense}k',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refreshPokemon,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
