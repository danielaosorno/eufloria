
import 'package:eufloria/scr/models/element.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:eufloria/scr/widgets/small_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ElementWidget extends StatelessWidget {

  final ElementModel element;
  //constructor
  const ElementWidget({Key key, this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: <Widget>[
          Container(
            
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: EdgeInsets.all(0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
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
                            image: element.image),
                            
                            
                      )
                    ],
                  )
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SmallButton(Icons.favorite),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
