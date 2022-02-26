// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutterapi/ProductList.dart';

import 'AddProduct.dart';
import 'ProductDelete.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 35, 61),
      appBar: AppBar(
        title: Text("Menu"),
        backgroundColor: Color.fromARGB(255, 3, 35, 61),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      child: Image.asset(
                    'assets/crud.png',
                    height: 200,
                  )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 150, 184, 212),
                    borderRadius: BorderRadius.circular(10)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductList()));
                  },
                  child: Text(
                    'Liste des Produits',
                    style: TextStyle(
                        color: Color.fromARGB(255, 2, 2, 2), fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 150, 184, 212),
                    borderRadius: BorderRadius.circular(10)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddProduct()));
                  },
                  child: Text(
                    'Ajouter Un Produit',
                    style: TextStyle(
                        color: Color.fromARGB(255, 2, 2, 2), fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
