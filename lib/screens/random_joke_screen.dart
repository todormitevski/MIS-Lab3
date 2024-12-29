import 'package:flutter/material.dart';
import 'package:mobis_lab2/widgets/gradient_scaffold.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: const Text("Random Joke"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<Joke>(
        future: ApiService.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(joke.setup, style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 20),
                      Text(joke.punchline, style: const TextStyle(fontSize: 22)),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text("No joke available"));
          }
        },
      ),
    );
  }
}
