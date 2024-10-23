import 'package:ecommerce_int2/screens/splash_page.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase Core
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegúrate de que los widgets estén inicializados
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(MyApp()); // Ejecuta tu aplicación
}

class MyApp extends StatelessWidget {
  // Este widget es la raíz de tu aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eCommerce int2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen(),
    );
  }
}
