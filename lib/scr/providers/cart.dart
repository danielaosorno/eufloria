import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eufloria/scr/helpers/order.dart';
import 'package:eufloria/scr/helpers/user.dart';
import 'package:eufloria/scr/models/cart_item.dart';
import 'package:eufloria/scr/models/order.dart';
import 'package:eufloria/scr/models/products.dart';
import 'package:eufloria/scr/models/user.dart';
import 'package:eufloria/scr/providers/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;


  CartProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }


  //getters
  //usamos getters para coger la informacion de manera mas segura, ya que las variables estan privadas
  Status get status => _status;
  UserModel get userModel => _userModel;
  FirebaseUser get user => _user;
  List<OrderModel> orders = [];
  
  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
  
  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      //si el usuario no existe,
      _status = Status.Uninitialized;
    } else {
      //si el usuario si existe,
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
    }
    //esto va a mostrarle al usuario lo que se va haciendo, la autenticacion y etc
    notifyListeners();
  }

  Future<bool> addToCard({ProductModel product, int quantity}) async {
    print("Añadido al carrito");
    print("cantidad: ${quantity.toString()}");
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;
      //bool itemExist = false;
      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
      print("Productos añadidos son: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);


      return true;
    } catch (e) {
      print("Error ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    print("Añadido al carrito: ${cartItem.toString()}");

    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);

      return true;
    } catch (e) {
      print("Error ${e.toString()}");
      return false;
    }
  }

  //cambiar esto a otra clase
  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

}