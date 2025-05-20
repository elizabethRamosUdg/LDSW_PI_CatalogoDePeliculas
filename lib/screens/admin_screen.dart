import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Administrar peliculas'),
        centerTitle: true,
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
  // Input de texto para nuevos capturar datos
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _sipnosisController = TextEditingController();
  final TextEditingController _imagenUrlController = TextEditingController();

  // Poder leer y crear nuevos documentos a nuestra coleccion en firebase
  final CollectionReference _movies = FirebaseFirestore.instance.collection(
    'movies',
  );

  // Leer peliculas que existen
  Stream<QuerySnapshot> getMoviesStream() {
    return _movies.snapshots();
  }

  void _addMovie() {
    final _editTitleController = TextEditingController();
    final _editYearController = TextEditingController();
    final _editDirectorController = TextEditingController();
    final _editGeneroController = TextEditingController();
    final _editSipnosisController = TextEditingController();
    final _editImagenURLController = TextEditingController();

    // Usamos un alert log para hacer esto mas facil
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Agregar Película'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _editTitleController,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: _editYearController,
                  decoration: InputDecoration(labelText: 'Año'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _editDirectorController,
                  decoration: InputDecoration(labelText: 'Director'),
                ),
                TextField(
                  controller: _editGeneroController,
                  decoration: InputDecoration(labelText: 'Genero'),
                ),
                TextField(
                  controller: _editSipnosisController,
                  decoration: InputDecoration(labelText: 'Sipnosis'),
                ),
                TextField(
                  controller: _editImagenURLController,
                  decoration: InputDecoration(labelText: 'Imagen'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: () async {
                  final newTitle = _editTitleController.text.trim();
                  final newYear = _editYearController.text.trim();
                  final newDirector = _editDirectorController.text.trim();
                  final newGenero = _editGeneroController.text.trim();
                  final newSipnosis = _editSipnosisController.text.trim();
                  final newImageURL = _editSipnosisController.text.trim();

                  // Validamos que todos los campos tengan informacion
                  if (newTitle.isNotEmpty &&
                      newYear.isNotEmpty &&
                      newDirector.isNotEmpty &&
                      newGenero.isNotEmpty &&
                      newSipnosis.isNotEmpty &&
                      newImageURL.isNotEmpty) {
                    await _movies.add({
                      'title': newTitle,
                      'year': newYear,
                      'director': newDirector,
                      'genero': newGenero,
                      'sipnosis': newSipnosis,
                      'imageURL': newImageURL,
                    });
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
    );
  }

  void _editMovie(
    String id,
    String currentTitle,
    String currentYear,
    String currentDirector,
    String currentGenero,
    String currentSipnosis,
    String currentImageURL,
  ) {
    final _editTitleController = TextEditingController(text: currentTitle);
    final _editYearController = TextEditingController(text: currentYear);
    final _editDirectorController = TextEditingController(
      text: currentDirector,
    );
    final _editGeneroController = TextEditingController(text: currentGenero);
    final _editSipnosisController = TextEditingController(
      text: currentSipnosis,
    );
    final _editImagenURLController = TextEditingController(
      text: currentImageURL,
    );

    // Usamos un alert log para hacer esto mas facil
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Editar Película'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _editTitleController,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: _editYearController,
                  decoration: InputDecoration(labelText: 'Año'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _editDirectorController,
                  decoration: InputDecoration(labelText: 'Director'),
                ),
                TextField(
                  controller: _editGeneroController,
                  decoration: InputDecoration(labelText: 'Genero'),
                ),
                TextField(
                  controller: _editSipnosisController,
                  decoration: InputDecoration(labelText: 'Sipnosis'),
                ),
                TextField(
                  controller: _editImagenURLController,
                  decoration: InputDecoration(labelText: 'Imagen'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: () async {
                  final newTitle = _editTitleController.text.trim();
                  final newYear = _editYearController.text.trim();
                  final newDirector = _editDirectorController.text.trim();
                  final newGenero = _editGeneroController.text.trim();
                  final newSipnosis = _editSipnosisController.text.trim();
                  final newImageURL = _editImagenURLController.text.trim();

                  // Validamos que todos los campos tengan informacion
                  if (newTitle.isNotEmpty &&
                      newYear.isNotEmpty &&
                      newDirector.isNotEmpty &&
                      newGenero.isNotEmpty &&
                      newSipnosis.isNotEmpty &&
                      newImageURL.isNotEmpty) {
                    await _movies.doc(id).update({
                      'title': newTitle,
                      'year': newYear,
                      'director': newDirector,
                      'genero': newGenero,
                      'sipnosis': newSipnosis,
                      'imageURL': newImageURL,
                    });
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
    );
  }

  // Eliminar pelicula
  void _deleteMovie(String id) async {
    await _movies.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Texto en el top
            Padding(
              padding: EdgeInsets.all(12), // Espaciado uniforme
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Add Movie'),
                    onPressed: _addMovie,
                  ),
                ],
              ),
            ),
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
                      final sipnosis = data['sipnosis'] ?? '-';
                      final imagenURL = data['imageURL'] ?? '-';

                      // Regresamos una lista con directorios
                      return ListTile(
                        leading: Text(index.toString()),
                        title: Text(title),
                        subtitle: Text(year.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.orange),
                              onPressed:
                                  () => _editMovie(
                                    document.id,
                                    title,
                                    year,
                                    director,
                                    genero,
                                    sipnosis,
                                    imagenURL,
                                  ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteMovie(document.id),
                            ),
                          ],
                        ),
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
