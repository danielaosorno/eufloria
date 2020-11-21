import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eufloria/scr/helpers/order.dart';
import 'package:eufloria/scr/helpers/user.dart';
import 'package:eufloria/scr/models/cart_item.dart';
import 'package:eufloria/scr/models/order.dart';
import 'package:eufloria/scr/models/products.dart';
import 'package:eufloria/scr/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

//aqui ira todo lo de la autenticacion
//coleccion de un particular tipo
enum Status { Uninitialized, Unaunthenthicated, Authenticating, Authenticated }

//
class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  OrderServices _orderServices = OrderServices();
  UserServices _userServices = UserServices();
  UserModel _userModel;

  //getters
  //usamos getters para coger la informacion de manera mas segura, ya que las variables estan privadas
  Status get status => _status;
  UserModel get userModel => _userModel;
  List<OrderModel> orders = [];

  FirebaseUser get user => _user;


  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  //constructor
  //dentro de este contructor vamos a escuchar el estado del usuario
  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  //método de inicio de sesión
  //retornará verdadero si es exitoso y falso si no
  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unaunthenthicated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  //método de registrarse
  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').document(result.user.uid).setData({
          "name": name.text,
          "email": email.text,
          "uid": result.user.uid,
          "cart": [],
        });
        //método que le pasa los datos anteriores a la variable de crear usuario
        //_userServices.createUser(user);
      });
      return true;
    } catch (e) {
      _status = Status.Unaunthenthicated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  //método de salir
  Future signOut() {
    _auth.signOut();
    _status = Status.Unaunthenthicated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  //método
  //cuando es llamado, los espacios van a ser vacios
  void clearController() {
    email.text = "";
    password.text = "";
    name.text = "";
  }

  //
  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  //método
  //cuando la autenticacion cambia, vamos a ejecutar algo, y el método es el siguiente

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
