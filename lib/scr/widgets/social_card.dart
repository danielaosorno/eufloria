import 'package:eufloria/scr/helpers/style.dart';
import 'package:flutter/material.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({Key key, this.icon, this.press}) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //iconos de redes sociales
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(12),
        height: 50,
        width: 45,
        decoration: BoxDecoration(
          color: white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(icon),
      ),
    );
  }
}
