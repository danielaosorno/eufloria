import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/products.dart';

class ProductServices {
  String collection = "products";
  Firestore _firestore = Firestore.instance;

  //aqui vamos a recibir toda la información puesta en la base de datos, y la
  //vamos a guardar en una variable que se llama products
  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  //para cuando el usuario le de clic en alguno de los widgets "especial para ti"
  //le aparezcan los productos de ese widget
  Future<List<ProductModel>> getProductsByElement({String id}) async =>
      _firestore
          .collection(collection)
          .where("elementId", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  //para cuando el usuario le de clic en alguna de las categorias, le aparezca
  //los productos dentro de esa categoria
  Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  //para cuando el usuario quiera buscar algo
  //si incluso pone una sola letra, el sistema le va a mostrar algo
  Future<List<ProductModel>> searchProducts({String productName}) {
    // codigo para las mayusculas y minusculas
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff']) //infinito
        .getDocuments()
        .then((result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.documents) {
            products.add(ProductModel.fromSnapshot(product));
          }
          return products;
        });
  }
}
