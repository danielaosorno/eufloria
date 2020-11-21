import 'package:eufloria/scr/helpers/screen_navigation.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/models/category.dart';
import 'package:eufloria/scr/providers/product.dart';
import 'package:eufloria/scr/screens/details.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:eufloria/scr/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryScreen({Key key, this.categoryModel}) : super(key: key);

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
                //aqui se llama a la imagen de la categoria
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: categoryModel.image,
                  height: 160,
                  width: double.infinity,
                ),
              ),
              Positioned(
                right: 50,
                top: 130,
                //bottom: 40,
                  child: Align(
                    child: CustomText(text: categoryModel.name, color: grey, size: 26, weight: FontWeight.w500,)
                    )
              ),
              Positioned.fill(
                  top: 5,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: black.withOpacity(0.2)
                              ),
                              child: Icon(Icons.close, color: white,)),
                        ),
                      ),)),
              
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //aqui se llaman los productos de cada categoria
          Column(
            
            children: productProvider.productsByCategory
                .map((item) => GestureDetector(
              onTap: () {
                changeScreen(context, Details(product: item,));
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
