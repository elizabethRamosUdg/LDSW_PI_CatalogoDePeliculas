import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  // Constructor
  const HomeScreen({
    super.key,
    required this.textoBienvenida,
    required this.titulo,
  });
  // Variables
  final String textoBienvenida;
  final String titulo;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wp.jpg'), // Ruta de la imagen
            fit: BoxFit.cover, // Ajustar imagen para cubrir toda la pantalla
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrar los text
            children: [
              Text(
                widget.titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38, // Tamaño
                  fontWeight: FontWeight.bold, // Para hacerlo más grueso
                ),
              ),
              Text(
                widget.textoBienvenida,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30, // Tamaño
                  fontWeight: FontWeight.bold, // Para hacerlo más grueso
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50), // width and height
                    ),
                    child: Text('Catalogo de peliculas'),
                    onPressed: () => Navigator.pushNamed(context, '/catalogo'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50), // width and height
                    ),
                    child: Text('Administrar'),
                    onPressed:
                        () => Navigator.pushNamed(context, '/administracion'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
