import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/admin_screen.dart';

void main() async {
  // Vamos a inizializar la configuracion, eso incluye los datos de coneccion con
  // nuestra app en la nube
  WidgetsFlutterBinding.ensureInitialized();
  // Vamos a esperar que el async obtenga su promise lo que quiere decir que
  // la configuracion esta echa
  await Firebase.initializeApp();
  // Correr la app
  runApp(LDSWApp());
}

class LDSWApp extends StatelessWidget {
  const LDSWApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo de Películas',
      initialRoute: '/',
      routes: {
        '/':
            (_) => HomeScreen(
              titulo: 'Catalogo de Peliculas',
              textoBienvenida: 'Bienvenido!!',
            ),
        '/catalogo': (_) => CatalogScreen(),
        '/admin': (_) => AdminScreen(),
      },
    );
  }
}
