
import 'package:eufloria/scr/helpers/style.dart';
import 'package:flutter/material.dart';


//esta clase es para reutilizar el codigo que esté aqui, el tamaño, color del texto
class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  //generando el constructor

  CustomText({@required this.text, this.size, this.color, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: size ?? 16, color: color ?? black, fontWeight: weight ?? FontWeight.normal),);
  }
}
