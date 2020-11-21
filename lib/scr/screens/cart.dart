import 'package:eufloria/scr/helpers/order.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/providers/app.dart';
import 'package:eufloria/scr/providers/cart.dart';
import 'package:eufloria/scr/providers/user.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:eufloria/scr/models/cart_item.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  //cambiar esto
  OrderServices _orderServices = OrderServices();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(
          text: "Carrito",
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: user.userModel.cart.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: grey,
                            offset: Offset(2, 1),
                            blurRadius: 2,
                          )
                        ]),
                    child: Row(
                      //donde va la informacion
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            child: Image.network(
                              user.userModel.cart[index].image,
                              height: 120,
                              width: 140,
                              fit: BoxFit.fill,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        user.userModel.cart[index].name + "\n",
                                    style:
                                        TextStyle(color: black, fontSize: 20)),
                                TextSpan(
                                    text:
                                        "\$${user.userModel.cart[index].price / 100}  \n\n",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: "Cantidad: ",
                                    style: TextStyle(
                                        color: grey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                    text: user.userModel.cart[index].quantity
                                        .toString(),
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400)),
                              ])),
                              SizedBox(
                                width: 0,
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.red[500]),
                                  onPressed: () async {
                                    app.changeLoading();
                                    bool value = await user.removeFromCart(
                                        cartItem: user.userModel.cart[index]);
                                    if (value) {
                                      user.reloadUserModel();
                                      _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Producto eliminado")));
                                      app.changeLoading();
                                      return;
                                    } else {
                                      print("no se pudo remover");
                                      app.changeLoading();
                                    }
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      //precio total y boton pagar
      bottomNavigationBar: Container(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Total: ",
                    style: TextStyle(
                        color: grey,
                        fontSize: 22,
                        fontWeight: FontWeight.w400)),
                TextSpan(
                    text: "\$${user.userModel.totalCartPrice / 100} ",
                    style: TextStyle(
                        color: blue,
                        fontSize: 22,
                        fontWeight: FontWeight.normal)),
              ])),
              Container(
                width: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: blue,
                ),
                child: FlatButton(
                  onPressed: () {
                    if (user.userModel.totalCartPrice == 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0)), //this right here
                              child: Container(
                                height: 220,
                                width: 370,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Tu carrito está vacío, intenta agregar un producto ☺',
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: Container(
                              height: 220,
                              width: 370,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Se te cobrará la suma de: \$${user.userModel.totalCartPrice / 100} a la entrega',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          //para que cree un id de la orden
                                          var uuid = Uuid();
                                          String id = uuid.v4();
                                          //para hacer que pase a las ordenes
                                          _orderServices.createOrder(
                                            userId: user.user.uid,
                                            id: id,
                                            description: "Algo",
                                            status: "En camino",
                                            totalPrice:
                                                user.userModel.totalCartPrice,
                                            cart: user.userModel.cart,
                                          );
                                          for (CartItemModel cartItem
                                              in user.userModel.cart) {
                                            //para que el carrito quede vacío después de la orden

                                            bool value =
                                                await user.removeFromCart(
                                                    cartItem: cartItem);
                                            if (value) {
                                              user.reloadUserModel();
                                              _key.currentState.showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          "Gracias por tu compra")));
                                            } else {
                                              print(
                                                  "No se pudo hacer el pedido");
                                            }
                                          }
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "La orden fue creada ☺")));
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Aceptar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: blue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Regresar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: CustomText(
                    text: "Hacer orden",
                    size: 20,
                    color: white,
                    weight: FontWeight.w300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
