//siempre que algo se este cargando, vamos a mostrar esta clase

import 'package:eufloria/scr/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SpinKitFadingCircle(
        color: black,
        size: 30,
      )
    );
  }
}