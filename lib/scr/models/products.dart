//import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {

  //vamos a usar esta clase para darle una estructura a los datos de la base de datos
  // esto va a ir dentro de la base de datos

  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const ELEMENT_ID = "elementId";
  static const ELEMENT = "element";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const RATES = "rates";
  //static const USER_LIKES = "userLikes";

  //variables que van a contener la informacion
  //estas variables son privadas

  String _id;
  String _name;
  String _elementId;
  String _element;
  String _category;
  String _image;
  String _description;
  double _rating;
  int _price;
  int _rates;
  bool _featured;

  //getters
  //aqui utilizamos los getters para obtener esas variables privadas
  String get id => _id;
  String get name => _name;
  String get restaurant => _element;
  String get restaurantId => _elementId;
  String get category => _category;
  String get description => _description;
  String get image => _image;
  double get rating => _rating;
  int get price => _price;
  bool get featured => _featured;
  int get rates => _rates;

  // public variable
  //bool liked = false;
//metodos
  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _image = snapshot.data[IMAGE];
    _element = snapshot.data[ELEMENT];
    _elementId = snapshot.data[ELEMENT_ID].toString();
    _description = snapshot.data[DESCRIPTION];
    _id = snapshot.data[ID];
    _featured = snapshot.data[FEATURED];
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _rating = snapshot.data[RATING];
    _rates = snapshot.data[RATES];
    _name = snapshot.data[NAME];
  }
}
