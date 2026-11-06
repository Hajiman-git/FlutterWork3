import 'package:dio/dio.dart';
import '../models/joke.dart';

class JokesRepository {
  final Dio _dio;

  JokesRepository(this._dio);

  Future<List<Joke>> getJokes({int limit = 5}) async {
    final requests = List.generate(
      limit,
      (_) => _dio.get('/dadjokes'),
    );

    final responses = await Future.wait(requests);
    
    return responses
        .map((response) {
          // API возвращает массив, даже если там 1 элемент
          final List<dynamic> data = response.data as List<dynamic>;
          return Joke.fromJson(data.first as Map<String, dynamic>);
        })
        .toList();
  }
}