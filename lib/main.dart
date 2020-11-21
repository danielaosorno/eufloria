import 'package:eufloria/scr/providers/app.dart';
import 'package:eufloria/scr/providers/cart.dart';
import 'package:eufloria/scr/providers/category.dart';
import 'package:eufloria/scr/providers/element.dart';
import 'package:eufloria/scr/providers/product.dart';
import 'package:eufloria/scr/providers/user.dart';
import 'package:eufloria/scr/screens/home.dart';
import 'package:eufloria/scr/screens/login.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppProvider()),
      //ChangeNotifierProvider.value(value: CartProvider.initialize()),
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
      ChangeNotifierProvider.value(value: ElementProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EUFLORIA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScreensController()
    ),
  ));
}

class ScreensController extends StatelessWidget {
  const ScreensController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      //checa ell estado del widget
      /*case Status.Uninitialized:
        return Loading();

      case Status.Unaunthenthicated:*/
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();

      default:
        return LoginScreen();
    }
  }
}
