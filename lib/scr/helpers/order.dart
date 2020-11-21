import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eufloria/scr/models/cart_item.dart';
import 'package:eufloria/scr/models/order.dart';

class OrderServices {
  //variables
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  //método crear ORDEN
  void createOrder({String userId, String id, String description, String status, List<CartItemModel> cart, int totalPrice}) {
    List<Map> convertedCart = [];

    for(CartItemModel item in cart){
     convertedCart.add(item.toMap());
   }

    _firestore.collection(collection).document(id).setData({
      "userId": userId,
      "id": id,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status,
    });
  }

  //metodo tomar ordenes de usuarios

  Future<List<OrderModel>> getUserOrders({String userId}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}