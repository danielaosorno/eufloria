import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  // esto va a ir dentro de la base de datos

  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  //variables que van a contener la informacion
  //estas variables son privadas
  String _id;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  int _total;

  //getters
  //aqui utilizamos los getters para obtener esas variables privadas
  String get id => _id;
  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;

  // public variable
  List cart;

  //metodos
  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _description = snapshot.data[DESCRIPTION];
    _total = snapshot.data[TOTAL];
    _status = snapshot.data[STATUS];
    _userId = snapshot.data[USER_ID];
    _createdAt = snapshot.data[CREATED_AT];
    cart = snapshot.data[CART];
  }
}
