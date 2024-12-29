import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Jokes"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteJokes = favoritesProvider.favorites;

          return favoriteJokes.isEmpty
              ? const Center(child: Text("No favorite jokes yet"))
              : ListView.builder(
            itemCount: favoriteJokes.length,
            itemBuilder: (context, index) {
              final joke = favoriteJokes[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      favoritesProvider.toggleFavorite(joke);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Joke removed from favorites!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
