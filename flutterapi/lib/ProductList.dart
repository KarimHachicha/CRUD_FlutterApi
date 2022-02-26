// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, dead_code, avoid_unnecessary_containers, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutterapi/ProductDelete.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EditProduct.dart';
import 'HomePage.dart';
import 'main.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int productId = 4;

  List produits = [];
  @override
  void initState() {
    super.initState();
    this.fetchUsers();
  }

  fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/product'));

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        produits = items;
        print(produits[0]['productName']);
      });
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 35, 61),
      appBar: AppBar(
        title: Text("Affichage des Produits"),
        backgroundColor: Color.fromARGB(255, 3, 35, 61),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
                child: Container(
              height: 20,
              child: Center(
                child: Text(
                  'La Liste Des Produits Disponibles :',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )),
          ),
          SizedBox(
            height: 30,
          ),
          for (var i = 0; i < produits.length; i++)
            Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  title: Text(produits[i]['productName']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            productId = produits[i]['id'];
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProduct(productId: productId)))
                                .then((value) => setState(
                                      () {
                                        ProductList();
                                      },
                                    ));
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            productId = produits[i]['id'];
                            print(productId);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDelete(productId)));
                            print(productId);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          Column(children: [
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 216, 216, 216),
                  borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: Text(
                  'Retour au Menu',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ]),
        ]),
      ),
    );
  }
}
