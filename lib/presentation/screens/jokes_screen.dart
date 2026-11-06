import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/models/joke.dart';
import '../../data/repositories/jokes_repository.dart';
import '../widgets/joke_card.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  final JokesRepository _repo = GetIt.I<JokesRepository>();
  final List<Joke> _jokes = [];
  bool _loading = false;
  String? _error;
  int _limit = 3;

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  Future<void> _loadJokes() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final jokes = await _repo.getJokes(limit: _limit);
      setState(() => _jokes.insertAll(0, jokes));
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _clear() => setState(() => _jokes.clear());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dad Jokes'),
        actions: [
          IconButton(
            tooltip: 'Очистить',
            icon: const Icon(Icons.delete_outline),
            onPressed: _clear,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Text('Кол-во: '),
                Expanded(
                  child: Slider(
                    value: _limit.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: '$_limit',
                    onChanged: (v) => setState(() => _limit = v.round()),
                  ),
                ),
                Text('$_limit'),
              ],
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Ошибка: $_error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          if (_loading) const LinearProgressIndicator(),
          Expanded(
            child: _jokes.isEmpty && !_loading
                ? const Center(child: Text('Пока нет данных'))
                : ListView.builder(
                    itemCount: _jokes.length,
                    itemBuilder: (_, i) => JokeCard(joke: _jokes[i]),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading ? null : _loadJokes,
        icon: const Icon(Icons.refresh),
        label: const Text('Загрузить'),
      ),
    );
  }
}