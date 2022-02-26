// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, dead_code

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HomePage.dart';

// @dart=2.10
class LoginFormValidation extends StatefulWidget {
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class _LoginFormValidationState extends State<LoginFormValidation> {
  List users = [];

  @override
  void initState() {
    super.initState();
    this.fetchUsers();
  }

  fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/user/'));

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        users = items;
      });
    } else {
      throw Exception('Error!');
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else {
      return "";
    }
  }

  Widget build(BuildContext context) {
    var email = users[0]['email'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Page Authentification"),
        backgroundColor: Color.fromARGB(255, 3, 35, 61),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/register.png')),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre Adresse Email',
                        hintText: 'Exemple : user@mail.com'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Ce champs est requis"),
                      EmailValidator(
                          errorText: "Le champs de l'émail est requis"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mot de passe',
                        hintText: 'Taper votre mot de passe'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Ce champs est requis"),
                      MinLengthValidator(6,
                          errorText: "Mot de passe minimum 6"),
                      MaxLengthValidator(15,
                          errorText: "Mot de passe maximum 15")
                    ])
                    //validatePassword,        //Function to check validation
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 3, 35, 61),
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomePage()));
                      print("Validé");
                    } else {
                      print("Non validé");
                    }
                  },
                  child: Text(
                    'Authentifier',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Mot de passe oublié?',
                  style: TextStyle(
                      color: Color.fromARGB(255, 3, 35, 61), fontSize: 15),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Nouveau utilisateur ? Cliquer ici'),
              Text(email)
            ],
          ),
        ),
      ),
    );
  }
}
