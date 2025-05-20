import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String year;
  final String director;
  final String genero;
  final String sinopsis;
  final String imagenURL;

  // Constructor para recibir los detalles de la película
  MovieDetailScreen({
    required this.title,
    required this.year,
    required this.director,
    required this.genero,
    required this.sinopsis,
    required this.imagenURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Imagen de la película
            // Es importante poner un catch, por que si la URL esta mal
            // Rompe la appliacion
            Image.network(
              imagenURL,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return CircularProgressIndicator(); // Muestra progreso mientras carga
              },
              errorBuilder: (context, error, stackTrace) {
                return Text('Error al cargar la imagen');
              },
            ),
            SizedBox(height: 16),
            // Título
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Año y director
            Text('Año: $year', style: TextStyle(fontSize: 18)),
            Text('Director: $director', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            // Género
            Text('Género: $genero', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            // Sinopsis
            Text('Sinopsis: $sinopsis', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
