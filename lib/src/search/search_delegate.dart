import 'package:flutter/material.dart';
import 'package:flutter_app_movies/src/models/pelicula_model.dart';
import 'package:flutter_app_movies/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculas = ['Spiderman 3', 'Capitan America 2', 'It'];
  final peliculasRecientes = ['Spiderman', 'Capitan America'];
  String seleccion;
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del searchBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la Izquiera del searchBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se van a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blue,
        child: Text(seleccion),
      ),
    );
  }

/*   @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando se escribe

    final listaBusqueda = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: listaBusqueda.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(
            listaBusqueda[index],
          ),
          onTap: () {
            seleccion = listaBusqueda[index];
            showResults(context);
          },
        );
      },
    );
  }
 */

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando se escribe
    if (query.isEmpty) return Container();
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        final peliculas = snapshot.data;
        return ListView(
          children: peliculas.map((p) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(p.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(p.title),
              subtitle: Text(p.originalTitle),
              onTap: () {
                close(context, null);
                p.uniqueId = '';
                Navigator.pushNamed(context, 'detalle', arguments: p);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
