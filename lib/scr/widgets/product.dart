
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/models/products.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:flutter/material.dart';


class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final elementProvider = Provider.of<ElementProvider>(context);
    //final productProvider = Provider.of<ProductProvider>(context);


    return  Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(-2, -1),
              blurRadius: 5
            ),
          ]
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 170,
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.network(product.image, fit: BoxFit.fill,),
              ),
            ),
            Expanded(
              child: Column(
                
                children: <Widget>[
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:12, left: 8),
                        child: CustomText(
                          text: product.name,
                          weight: FontWeight.w400,
                        ),
                      ),
                      
                      //boton de favoritos
                      Padding(
                        padding: EdgeInsets.only(top: 10, right:8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(20),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    offset: Offset(1, 1),
                                    blurRadius: 4),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "ENVÍO GRATIS",
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CustomText(
                              text: product.rating.toString(),
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
                        padding: const EdgeInsets.only(right:8.0),
                        child: CustomText(text: "\$${ product.price / 100}",weight: FontWeight.bold,),
                      ),
                    ],
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}