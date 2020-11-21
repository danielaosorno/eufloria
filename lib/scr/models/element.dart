import 'package:cloud_firestore/cloud_firestore.dart';

  //vamos a usar esta clase para darle una estructura a los datos de la base de datos
  // esto va a ir dentro de la base de datos


class ElementModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const POPULAR = "popular";
  //static const USER_LIKES = "userLikes";

 //variables que van a contener la informacion
  //estas variables son privadas
  String _id;
  String _name;
  String _image;
  List<String> _userLikes;
  bool _popular;

//  getters
 //getters
  //aqui utilizamos los getters para obtener esas variables privadas
  String get id => _id;
  String get name => _name;
  String get image => _image;
  List<String> get userLikes => _userLikes;
  bool get popular => _popular;

  // public variable
  //bool liked = false;

  ElementModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _image = snapshot.data[IMAGE];
    _popular = snapshot.data[POPULAR];
  }
}
