import 'package:eufloria/scr/helpers/screen_navigation.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/providers/product.dart';
import 'package:eufloria/scr/screens/details.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'custom_text.dart';


//esta clase muestra todos los productos que esten en la lista anterior, y los acomoda en orden
class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    //final user = Provider.of<UserProvider>(context);


    return Container(
      height: 300,
      //width: 900,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider.products.length,
          itemBuilder: (_, index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
                child: GestureDetector(
                  //para cambiar a los detalles de la imagen y añadir al carrito
                  onTap: () {
                    changeScreen(
                        _,
                        Details(
                          product: productProvider.products[index],
                        ));
                  },
                  child: Container(
                    height: 300,
                    width: 270,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(1, 1),
                              blurRadius: 20),
                        ]),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Loading(),
                              )),
                              Center(
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: productProvider.products[index].image,
                                  height: 200,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CustomText(
                                text: productProvider.products[index].name ??"id null",
                                color: black,
                                
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: (){
//                                  setState(() {
//                                    productProvider.products[index].liked = !productProvider.products[index].liked;
//                                  });
//                                  productProvider.likeDislikeProduct(userId: user.userModel.id, product: productProvider.products[index], liked: productProvider.products[index].liked);
                                },
                                child: Container(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: CustomText(
                                    text: productProvider.products[index].rating
                                        .toString(),
                                    color: grey,
                                    size: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.star,
                                  color: blue,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: blue,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: blue,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: blue,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star_half,
                                  color: blue,
                                  size: 16,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: CustomText(
                                text:
                                    "\$${productProvider.products[index].price / 100}",
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}