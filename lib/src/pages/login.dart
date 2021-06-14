import 'package:flutter/material.dart';
import 'package:prueba_cerrada/src/pages/register.dart';
import 'package:prueba_cerrada/src/pages/tab.dart';
//import 'src/pages/register.dart';
//import 'src/pages/home.dart';

class LoginPage extends StatefulWidget {
  // Initially password is obscure

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
              children: <Widget>[
                Container(
                 alignment: Alignment.center,
                 padding: EdgeInsets.fromLTRB(60,100,60,40),
                 child: Image.asset("assets/iconoLogin.png", width:170, height: 170),                
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(60,10,60,20),
                  child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                      labelText: 'Usuario',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(60,10,60,10),
                  child: TextField(
                      obscureText: hidePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: Theme.of(context)
                        .accentColor
                        .withOpacity(0.9),
                        icon: Icon(hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  //child: Text('Forgot Password'),
                ),
                Container(
                  height: 50,
                  width: 310,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    textColor: Colors.white,
                    color: Color.fromRGBO(0, 176, 70, 69),
                    child: Text('Iniciar sesión', style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                           builder: (context) => TabView()),
                      );                   
                      },
                  )
                ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      children: <Widget>[
                        Text('¿No tienes una cuenta?',style: TextStyle(fontSize: 14)),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Registrate',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            print("Regístrate");
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  )
              ],
            )
      )
    );
  }
}