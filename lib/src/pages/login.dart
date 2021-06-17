import 'package:http/http.dart' as http; 
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prueba_cerrada/src/pages/register.dart';
import 'package:prueba_cerrada/src/pages/tab.dart';
import 'package:prueba_cerrada/src/models/Login.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'src/pages/register.dart';
//import 'src/pages/home.dart';

class LoginPage extends StatefulWidget {
  // Initially password is obscure

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  Future<List<Login>> loginFinal;
  Login loginD;

  Future<List<Login>> postLogin(String username, String password) async{
    List<Login> login = [];

    String url = 'http://localhost:3000/signin';

    Map<String, String> params = {
      "username" : username,
      "password" : password
    };

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Access-Control-Allow-Origin": "*",
    };

    Uri uri = Uri.parse(url);

    final response = await http.post(uri, headers:header, body:jsonEncode(params));

    if(response.statusCode == 200 || response.statusCode == 404 || response.statusCode == 401 ){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      login.add(Login(jsonData['auth'],jsonData['token']));
      return login;
    }
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;
  bool isApiCallProcess = false;
  //GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  //final scaffoldKey = GlobalKey<ScaffoldState>();
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
                      //print(nameController.text);
                      //print(passwordController.text);
                      loginFinal = postLogin(nameController.text, passwordController.text);
                      loginFinal.then((value) => {
                        if(value[0].auth == true){
                          print("LOGIN CORRECTO"),
                          print(value[0].auth),
                          print(value[0].token),
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => TabView(
                          )),
                          ),
                        }else{
                          print("ERROR - El usuario o contraseña son incorrectos"),
                          print("Revise los datos ingresados"),
                          _showAlertDialog()
                    
                        }
                      });
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
  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text("ERROR"),
          content: Text("El usuario o contraseña son incorrectos"),
          actions: <Widget>[
            RaisedButton(
              child: Text("CERRAR", style: TextStyle(color: Colors.black),),
              onPressed: (){ Navigator.of(context).pop(); },
            )
          ],
        );
      }
    );
  }
}