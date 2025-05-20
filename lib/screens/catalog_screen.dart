import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'movie_detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Catálogo de Películas'),
        leading: BackButton(), // Esto asegura que se muestre el botón "atrás"
      ),
      body: MoviesHomePage(title: 'Películas'),
    );
  }
}

// Usamos un stateful widget para poder cambiar el estado de cada objeto de \
// pelicula
class MoviesHomePage extends StatefulWidget {
  const MoviesHomePage({super.key, required this.title});
  final String title;

  @override
  State<MoviesHomePage> createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
  // Poder leer y crear nuevos documentos a nuestra coleccion en firebase
  final CollectionReference _movies = FirebaseFirestore.instance.collection(
    'movies',
  );

  // Leer peliculas que existen
  Stream<QuerySnapshot> getMoviesStream() {
    return _movies.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Cargar peliculas en la coleccion
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getMoviesStream(), // Obtenemos nuestras peliculas
                builder: (context, snapshot) {
                  // En caso de que no se hayan cargado todavia los datos
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // En caso de estear vacio
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No hay peliculas aun'));
                  }

                  // Obtenemos la lista de documentos desde el snapshot
                  List<QueryDocumentSnapshot> movieDocuments =
                      snapshot.data!.docs;

                  return ListView.builder(
                    // Total de items
                    itemCount: movieDocuments.length,
                    // Creamos cada item
                    itemBuilder: (context, index) {
                      // Leemos el documento actual
                      final document = movieDocuments[index];
                      // Vamos a mapear los datos
                      final data = document.data() as Map<String, dynamic>;
                      // Cargamos los datos y los renderisamos usando ListTitle
                      final title = data['title'] ?? '-';
                      final year = data['year'] ?? '-';
                      final director = data['director'] ?? '-';
                      final genero = data['genero'] ?? '-';
                      final sinopsis = data['sinopsis'] ?? '-';
                      final imagenURL = data['imageURL'] ?? '-';

                      // Regresamos una lista con directorios
                      return ListTile(
                        leading: Icon(Icons.movie),
                        title: Text(title),
                        subtitle: Text('$year - $year'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => MovieDetailScreen(
                                    title: title,
                                    year: year,
                                    director: director,
                                    genero: genero,
                                    sinopsis: sinopsis,
                                    imagenURL: imagenURL,
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
