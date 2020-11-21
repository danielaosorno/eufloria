import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eufloria/scr/models/cart_item.dart';
import 'package:eufloria/scr/models/user.dart';

class UserServices {
  //variables
  String collection = "users";
  Firestore _firestore = Firestore.instance;

  //método crear usuario
  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  //método editar usuario
  void updateUserData(Map<String, dynamic> values) {
    _firestore.collection(collection).document(values['id']).updateData(values);
  }

  void addToCart({String userId, CartItemModel cartItem}) {
    print("el id sel usuario es: $userId");
    print("los productos son: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    print("el id del usuario es: $userId");
    print("los productos son: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

  //metodo final, se usa Future para hacer algo que se promete si todo sale bien
  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}
