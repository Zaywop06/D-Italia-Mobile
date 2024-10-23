import 'package:firebase_database/firebase_database.dart';

class CategoryService {
  late DatabaseReference dbRef;
  late DatabaseReference categoriesRef;

  CategoryService() {
    dbRef = FirebaseDatabase.instance.ref();
    categoriesRef = dbRef.child("categorias");
  }

  // Método para escuchar cambios en la base de datos
  Stream<List<Map<String, dynamic>>> listenToCategories() {
    return categoriesRef.onValue.map((DatabaseEvent event) {
      final snapshot = event.snapshot;

      if (snapshot.exists) {
        final List<Map<String, dynamic>> categoryList = [];

        // Itera sobre cada hijo de la referencia de categorías
        snapshot.children.forEach((childSnapshot) {
          // Convierte cada categoría en un mapa que contiene todo su contenido
          final categoryData = childSnapshot.value as Map<dynamic, dynamic>;
          categoryList.add({
            'id': childSnapshot.key, // Agrega el ID de la categoría
            'data': categoryData, // Agrega todos los datos de la categoría
            // Aquí puedes incluir otros campos si es necesario
          });
        });

        return categoryList; // Retorna la lista de categorías
      } else {
        print('No categories found.');
        return [];
      }
    });
  }

  // Método para limpiar la suscripción
  void dispose() {
    categoriesRef.onDisconnect(); // Desconéctate para evitar fugas de memoria
  }
}
