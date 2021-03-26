import 'package:flutter_app_movies/src/models/actor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_app_movies/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '5cfcb528d1d05df20145028ce1cb076e';
  String _url = 'api.themoviedb.org';
  String _language = 'es_ES';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesSteam =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _sendPetition(Uri endpoint) async {
    final resp = await http.get(endpoint);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    return await _sendPetition(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final respuesta = await _sendPetition(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);
    _cargando = false;
    return respuesta;
  }

  Future<List<Actor>> getCast(String peliculaId) async {
    final url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final cast = new Cast.fromJsonMap(decodeData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    return await _sendPetition(url);
  }
}
