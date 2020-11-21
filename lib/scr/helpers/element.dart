import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/element.dart';

//aqui es donde vamos a llamar a nuestra base de datos para obtener las imagenes

class ElementServices {
  String collection = "elements";
  Firestore _firestore = Firestore.instance;

  //método que se usará  base de datos

  Future<List<ElementModel>> getElements() async =>
    _firestore.collection(collection).getDocuments().then((result) {
      List<ElementModel> elements = [];
      for (DocumentSnapshot element in result.documents) {
        elements.add(ElementModel.fromSnapshot(element));
      }
      return elements;
    }
  );

  Future<ElementModel> getElementById({String id}) => _firestore.collection(collection).document(id.toString()).get().then((doc){
    return ElementModel.fromSnapshot(doc);
  });

  //para cuando el usuario quiera buscar algo
  //si incluso pone una sola letra, el sistema le va a mostrar algo
  Future<List<ElementModel>> searchElement({String elementName}) {
    // codigo para las mayusculas y minusculas
    String searchKey = elementName[0].toUpperCase() + elementName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff']) //infinito
        .getDocuments()
        .then((result) {
          List<ElementModel> elements = [];
          for (DocumentSnapshot product in result.documents) {
            elements.add(ElementModel.fromSnapshot(product));
          }
          return elements;
        });
  }

}
