import 'package:flutter/material.dart';
import 'package:mobis_lab2/widgets/gradient_scaffold.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../services/api_services.dart';
import '../widgets/joke_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: const Text(
          "Joker",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions),
            onPressed: () {
              Navigator.pushNamed(context, '/randomJoke');
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiService.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  type: jokeTypes[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/jokesByType',
                      arguments: jokeTypes[index],
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("No joke types available"));
          }
        },
      ),
    );
  }
}
