import 'package:flutter/material.dart';
import 'package:flutter_app_movies/src/widgets/card_swiper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _swiperTarjetas(),
          ],
        ),
      ),
    );
  }
}

Widget _swiperTarjetas() {
  return CardSwiper(peliculas: [1, 23, 4, 5, 56, 67]);
}
