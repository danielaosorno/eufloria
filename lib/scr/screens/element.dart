import 'package:eufloria/scr/helpers/screen_navigation.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/models/element.dart';
import 'package:eufloria/scr/providers/product.dart';
import 'package:eufloria/scr/screens/details.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:eufloria/scr/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ElementScreen extends StatelessWidget {
  final ElementModel elementModel;
  const ElementScreen({Key key, this.elementModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: Loading(),
              )),
              ClipRRect(
                //aqui se llama a la imagen
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: elementModel.image,
                  height: 190,
                  width: double.infinity,
                ),
              ),
              Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        //close buton
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: black.withOpacity(0.2)),
                            child: Icon(
                              Icons.close,
                              color: white,
                            )),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //se llaman los productos que están en ese elemento (especial para ti)
          Column(
            children: productProvider.productsByElement
                .map((item) => GestureDetector(
                      onTap: () {
                        changeScreen(
                            context,
                            Details(
                              product: item,
                            ));
                      },
                      child: ProductWidget(
                        product: item,
                      ),
                    ))
                .toList(),
          )
        ],
      )),
    );
  }
}
