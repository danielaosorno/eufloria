import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eufloria/scr/models/cart_item.dart';

//vamos a usar esta clase para darle una estructura a los datos de la base de datos
// esto va a ir dentro de la base de datos
class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  //variables que van a contener la informacion
  //estas variables son privadas
  String _name;
  String _email;
  String _id;
  String _stripeId;
  int _priceSum = 0;
  int _quantitySum = 0;

  //getters
  //aqui utilizamos los getters para obtener esas variables
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;

  //variables publica
  List<CartItemModel> cart;
  int totalCartPrice;

  //metodos
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _stripeId = snapshot.data[STRIPE_ID];
    cart = _convertCartItems(snapshot.data[CART]) ?? [];
    totalCartPrice = snapshot.data[CART] == null ? 0:getTotalPrice(cart: snapshot.data[CART]);
  }

  
  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }
    int total = _priceSum;
    print("precio total: $total");
    return total;
  }

  //los convertimos a cart item model
  //vamos a tenerlos como map en la base de datos, pero los vamos a convertir en listas
  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

}
