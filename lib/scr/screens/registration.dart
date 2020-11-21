import 'package:eufloria/scr/helpers/screen_navigation.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/providers/user.dart';
import 'package:eufloria/scr/screens/login.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:eufloria/scr/widgets/social_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Completa el formulario o ingresa \ncon redes sociales ☺",
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/logo 2.png",
                        width: 300,
                        height: 300,
                      )
                    ],
                  ),
                  Padding(
                    //linea para ingresar correo
                    padding: const EdgeInsets.all(12),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            controller: authProvider.name,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Nombre completo",
                                icon: Icon(Icons.person)),
                          ),
                        )),
                  ),
                  Padding(
                    //linea para ingresar correo
                    padding: const EdgeInsets.all(12),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            controller: authProvider.email,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Correo",
                                icon: Icon(Icons.email)),
                          ),
                        )),
                  ),
                  Padding(
                    //linea para ingresar contraseña
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          controller: authProvider.password,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contraseña",
                              icon: Icon(Icons.lock)),
                        ),
                      ),
                    ),
                  ),
                  CustomText(text: "* La contraseña debe tener más de 8 caracteres", size: 13, color: Colors.grey, weight: FontWeight.w500,),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    //boton de continuar para registrarse
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      //para el clic
                      onTap: () async {
                        print("btn clicked");
                        if (!await authProvider.signUp()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("Registration failed")));
                          return;
                        }
                        //aqui se pasa a la pantalla de inicio
                        authProvider.clearController();
                        changeScreenReplacement(context, Home());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: blue,
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  text: "Registrarse",
                                  color: white,
                                  size: 22,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //para clic
                      changeScreen(context, LoginScreen());
                    },
                    child: Padding(
                      //boton de iniciar sesion
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  text: "Iniciar sesión",
                                  color: blue,
                                  size: 22,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialCard(
                        icon: "images/google.png",
                        press: () {},
                      ),
                      SocialCard(
                        icon: "images/facebook.png",
                        press: () {},
                      ),
                      SocialCard(
                        icon: "images/twitter.png",
                        press: () {},
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Al continuar significa que estas de acuerdo \ncon nuestros términos y condiciones',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
    );
  }
}
