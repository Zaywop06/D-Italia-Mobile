import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart'; // Importa la base de datos
import 'components/staggered_category_card.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Category> categories = [];
  List<Category> searchResults = [];
  TextEditingController searchController = TextEditingController();
  late DatabaseReference dbRef; // Referencia a la base de datos
  late DatabaseReference categoriesRef; // Referencia a la lista de categorías

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance
        .ref(); // Inicializa la referencia de la base de datos
    categoriesRef =
        dbRef.child("categorias"); // Apunta a la referencia de categorías
    listenToCategories(); // Escuchar cambios en categorías
  }

  // Método para escuchar cambios en la base de datos
  void listenToCategories() {
    categoriesRef.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;

      if (snapshot.exists) {
        final List<dynamic> categoryList =
            snapshot.value as List<dynamic>? ?? [];

        setState(() {
          categories = categoryList.map((item) {
            return Category(
              Color.fromARGB(255, 65, 65, 65), // Ajustar colores si es necesario
              Color.fromARGB(255, 0, 0, 0),
              item['nombre'], // Asignar el nombre de la categoría
              'assets/jeans_5.png', // Cambia esto si tienes imágenes específicas
            );
          }).toList();
          searchResults =
              List.from(categories); // Inicializa los resultados de búsqueda
        });
      } else {
        print('No categories found.');
      }
    });
  }

  @override
  void dispose() {
    // Cancela la suscripción cuando el widget se destruye
    categoriesRef.onDisconnect(); // Desconéctate para evitar fugas de memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Asegúrate de tener este método
    return Material(
      color: Color(0xffF9F9F9),
      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment(-1, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Categorías',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.white,
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Buscar',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/search_icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    List<Category> tempList = [];
                    categories.forEach((category) {
                      if (category.category
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        tempList.add(category);
                      }
                    });
                    setState(() {
                      searchResults =
                          tempList; // Actualiza los resultados de búsqueda
                    });
                  } else {
                    setState(() {
                      searchResults = List.from(
                          categories); // Reinicia a todas las categorías
                    });
                  }
                },
              ),
            ),
            Flexible(
              child: searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (_, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: StaggeredCardCard(
                          begin: searchResults[index].begin,
                          end: searchResults[index].end,
                          categoryName: searchResults[index].category,
                          assetPath: searchResults[index].image,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'No se encontraron categorías.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
