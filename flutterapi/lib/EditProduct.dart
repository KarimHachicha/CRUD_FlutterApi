// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProduct extends StatefulWidget {
  int productId;
  EditProduct({Key? key, required this.productId}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

final ProductNameController = TextEditingController();

class _EditProductState extends State<EditProduct> {
  List products = [];
  bool isLoading = false;

  Future<http.Response> modifyProduct(int id, String productName) async {
    List produits = [];
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/product/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'productName': productName,
      }),
    );
    if (response.statusCode == 200) {
      return produits = jsonDecode(response.body);
    } else {
      throw Exception('Error!');
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Future<dynamic>? future;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 3, 35, 61),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("Modifier le nom du produit"),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 3, 35, 61),
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 200),
              child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Taper le nouveau nom du produit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: TextFormField(
                            controller: ProductNameController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'Tapez le nouveau nom',
                              labelStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              hintText: 'Taper le nom du produit',
                              hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 155, 150, 150)),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Ce champs est requis')
                            ])),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 216, 216, 216),
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    future = modifyProduct(widget.productId,
                                        ProductNameController.text);
                                    Navigator.pop(context, true);
                                  });
                                } else {
                                  print("Non validé");
                                }
                              },
                              child: Text('Modifier',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))))
                    ],
                  )),
            ))));
  }
}
