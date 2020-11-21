import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/models/category.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final categoryProvider = Provider.of<CategoryProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: white,
            ),
            child: Padding(
              padding: EdgeInsets.all(4),
              //imagenes de las categorias
              child: Image.network(
                category.image,
                width: 60,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          CustomText(
            //nombres de las categorias
            text: category.name,
            size: 16,
            color: black,
          )
        ],
      ),
    );
  }
}
