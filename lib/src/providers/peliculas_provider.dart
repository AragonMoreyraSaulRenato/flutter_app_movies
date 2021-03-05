import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_movies/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '5cfcb528d1d05df20145028ce1cb076e';
  String _url = 'https://api.themoviedb.org';
  String _language = 'es_ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api-key': _apiKey,
      'language': _language,
    });
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }
}
