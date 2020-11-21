import 'package:eufloria/scr/helpers/screen_navigation.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/providers/app.dart';
import 'package:eufloria/scr/providers/cart.dart';
import 'package:eufloria/scr/providers/category.dart';
import 'package:eufloria/scr/providers/element.dart';
import 'package:eufloria/scr/providers/product.dart';
import 'package:eufloria/scr/providers/user.dart';
import 'package:eufloria/scr/screens/cart.dart';
import 'package:eufloria/scr/screens/category.dart';
import 'package:eufloria/scr/screens/element.dart';
import 'package:eufloria/scr/screens/elements_search.dart';
import 'package:eufloria/scr/screens/login.dart';
import 'package:eufloria/scr/screens/order.dart';
import 'package:eufloria/scr/screens/product_search.dart';
import 'package:eufloria/scr/widgets/categories.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:eufloria/scr/widgets/element.dart';
import 'package:eufloria/scr/widgets/featured_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final elementProvider = Provider.of<ElementProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: Colors.blue[300],
        elevation: 0.5,
        actions: [
          Stack(
            children: <Widget>[
              IconButton(
                  //icono de carrito
                  iconSize: 28,
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: black,
                  ),
                  onPressed: () {
                    changeScreen(context, CartScreen());
                  }),
            ],
          ),
        ],
      ),
      //3 barras de arriba
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //aqui llamamos al nombre de usuario y correo, para que automaticamente se ponga ahí
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[300],
              ),
              accountName: CustomText(
                text: user.userModel.name,
                weight: FontWeight.bold,
                size: 20,
              ),
              accountEmail: CustomText(
                text: user.userModel.email,
                color: Colors.grey[800],
              ),
            ),
            //opciones con iconos para el inicio, carro, etc
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home_outlined),
              title: CustomText(
                text: "Inicio",
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart_outlined),
              title: CustomText(
                text: "Carrito",
              ),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrderScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(
                text: "Mis pedidos",
              ),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreen(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(
                text: "Salir",
              ),
            ),
          ],
        ),
      ),
      backgroundColor: white, //color de fondo
      //para que se muestre que la app está cargando
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: 12),
                child: Container(
                  //para darle color a la barra de busqueda
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    //barra de busqueda
                    leading: Icon(
                      Icons.search,
                      color: blue,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern) async {
                        //esto permite la busqueda de los productos
                        app.changeLoading();
                        if (app.search == SearchBy.PRODUCTS) {
                          await productProvider.search(productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        } else {
                          await elementProvider.search(name: pattern);
                          changeScreen(context, ElementsSearchScreen());
                        }
                        app.changeLoading();
                      },
                      decoration: InputDecoration(
                          hintText: "Buscar producto",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: "Categorias",
                size: 25,
                color: grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await productProvider.loadProductsByCategory(
                          categoryName:
                              categoryProvider.categories[index].name);
                      changeScreen(
                          context,
                          CategoryScreen(
                            categoryModel: categoryProvider.categories[index],
                          ));
                    },
                    child: CategoryWidget(
                      category: categoryProvider.categories[index],
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: "Productos populares",
                size: 25,
                color: grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Featured(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: "Especial para ti",
                size: 25,
                color: grey,
              ),
            ),

            //vista en vertical de las imagenes
            Column(
              children: elementProvider.elements
                  .map((item) => GestureDetector(
                        onTap: () async {
                          await productProvider.loadProductsByElement(
                              elementId: item.id);
                          changeScreen(
                              context, ElementScreen(elementModel: item));
                        },
                        child: ElementWidget(
                          element: item,
                        ),
                      ))
                  .toList(),
            ),

          ],
        ),
      ),
    );
  }
}
