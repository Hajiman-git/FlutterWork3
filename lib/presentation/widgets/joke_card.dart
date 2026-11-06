import 'package:flutter/material.dart';
import '../../data/models/joke.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.sentiment_very_satisfied, color: Colors.orange),
            const SizedBox(width: 8),
            Expanded(child: Text(joke.joke)),
          ],
        ),
      ),
    );
  }
}