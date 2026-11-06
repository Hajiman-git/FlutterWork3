class Joke {
  final String joke;

  Joke({required this.joke});

  factory Joke.fromJson(Map<String, dynamic> json) =>
      Joke(joke: json['joke'] as String? ?? '');
}