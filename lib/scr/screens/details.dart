
import 'package:eufloria/scr/helpers/screen_navigation.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/models/products.dart';
import 'package:eufloria/scr/providers/app.dart';
import 'package:eufloria/scr/providers/cart.dart';
import 'package:eufloria/scr/providers/user.dart';
import 'package:eufloria/scr/screens/cart.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  //vamos a llamar a los productos populares
  final ProductModel product;

  //constructor, se requiere el producto
  Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

//cuando hagamos clic en el producto, va a abrir los detalles del producto
class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

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
        actions: <Widget>[
          IconButton(
            iconSize: 28,
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: app.isLoading
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 155,
                    backgroundImage: NetworkImage(widget.product.image),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      text: widget.product.name,
                      size: 26,
                      weight: FontWeight.bold),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "\$${widget.product.price / 100}",
                    size: 20,
                    weight: FontWeight.w600,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text: "Descripción:", size: 18, weight: FontWeight.w400),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.description,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: grey, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 36,
                            ),
                            onPressed: () {
                              if (quantity != 1) {
                                setState(() {
                                  quantity -= 1;
                                });
                              }
                            }),
                      ),
                      GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          print("cargando...");

                          bool value = await user.addToCard(
                              product: widget.product, quantity: quantity);
                          if (value) {
                            print("Producto añadido al carrito");
                            _key.currentState.showSnackBar(
                                SnackBar(content: Text("Producto añadido :)")));
                            user.reloadUserModel();
                            app.changeLoading();
                            return;
                          } else {
                            print("No se pudo añadir al carrito :(");
                          }
                          print("no se pudo");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20)),
                          child: app.isLoading
                              ? Loading()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                  child: CustomText(
                                    text: "Añadir $quantity al carrito",
                                    color: white,
                                    size: 22,
                                    weight: FontWeight.w300,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 36,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
