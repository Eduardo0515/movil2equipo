import 'dart:convert';
import 'dart:io';

import 'package:prueba_cerrada/src/models/Register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prueba_cerrada/src/pages/login.dart';

class RegisterPage extends StatefulWidget {
  // Initially password is obscure
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<RegisterPage> {
  Future<Register> registerFinal;
  Register registerD;

  Future<Register> postRegister(
      String user, String email, String password, String repeatPassword) async {
    String url = 'http://192.168.43.89:3000/signup';

    Map<String, String> params = {
      "username": user,
      "email": email,
      "password": password,
      "repeatPassword": repeatPassword
    };

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Access-Control-Allow-Origin": "*",
    };

    Uri uri = Uri.parse(url);

    final response =
        await http.post(uri, headers: header, body: jsonEncode(params));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Registro correcto',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey.shade700,
          textColor: Colors.white,
          fontSize: 14.0);
    } else {
      Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey.shade700,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  bool hidePassword = true;
  bool isApiCallProcess = false;
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
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.fromLTRB(60, 10, 60, 20),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              labelText: 'Nombre de Usuario',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(60, 10, 60, 20),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              labelText: 'Correo',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
          child: Column(
            children: [
              TextField(
                obscureText: hidePassword,
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Theme.of(context).accentColor.withOpacity(0.9),
                    icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                obscureText: hidePassword,
                controller: repeatPasswordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Confirmar contraseña',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Theme.of(context).accentColor.withOpacity(0.9),
                    icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
            height: 50,
            width: 310,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0)),
              textColor: Colors.white,
              color: Color.fromRGBO(0, 176, 70, 69),
              child: Text('Registrarse', style: TextStyle(fontSize: 18)),
              onPressed: () {
                print(nameController.text);
                print(emailController.text);
                print(passwordController.text);
                print(repeatPasswordController.text);
                registerFinal = postRegister(
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                    repeatPasswordController.text);
              },
            )),
        Container(
            padding: EdgeInsets.all(30),
            child: Row(
              children: <Widget>[
                Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 14)),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text(
                    'Inicia sesión',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    print("Inicia sesión");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
      ],
    )));
  }
}
