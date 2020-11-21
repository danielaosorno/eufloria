import 'package:eufloria/scr/helpers/screen_navigation.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/providers/user.dart';
import 'package:eufloria/scr/screens/registration.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:eufloria/scr/widgets/social_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

//creando la estructura de la pantalla de login
class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      //vamos a verificar si el estado es autenticado, vamos a mostrar que la app esta cargando algo xd:
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "¡Bienvenido de nuevo!",
                    style: TextStyle(
                      color: black,
                      fontSize: 28,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ingresa con tu correo y contraseña  \no continúa con redes sociales ☺",
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
                            //con esta linea de codigo, se guarda el correo
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
                          //con esta linea de codigo, se guarda la contraseña
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
                  

                  Padding(
                    //boton de iniciar sesion
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      //para el clic
                      onTap: () async {
                        if (!await authProvider.signIn()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("Login failed")));
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
                                  text: "Iniciar sesión",
                                  color: white,
                                  size: 22,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),

                  GestureDetector(
                    //boton de registrarse
                    onTap: () {
                      //para clic
                      changeScreen(context, RegistrationScreen());
                    },
                    child: Padding(
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
                                  text: "Registrarse",
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
                  //terminos y condiciones
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
