import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

//aqui es donde vamos a llamar a nuestra base de datos para obtener las imagenes

class CategoryServices {
  String collection = "categories";
  Firestore _firestore = Firestore.instance;

  //método que se usará en las categorias de la base de datos

  Future<List<CategoryModel>> getCategories() async =>
    _firestore.collection(collection).getDocuments().then((result) {
      List<CategoryModel> categories = [];
      for (DocumentSnapshot category in result.documents) {
        categories.add(CategoryModel.fromSnapshot(category));
      }
      return categories;
    }
  );
}