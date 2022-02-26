// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, dead_code, unnecessary_this, must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutterapi/ProductList.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HomePage.dart';

fetchUsers(productId) async {
  final response = await http.delete(
    Uri.parse('http://127.0.0.1:8000/api/product/$productId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

class ProductDelete extends StatelessWidget {
  int productId;
  ProductDelete(this.productId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Page Authentification"),
          backgroundColor: Color.fromARGB(255, 3, 35, 61),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(50),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 218, 9, 9),
                  borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                onPressed: () {
                  fetchUsers(productId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Suppression en cours')),
                  );
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductList()));
                  });
                },
                child: Text(
                  'Confirmer la suppression',
                  style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 2), fontSize: 17),
                ),
              ),
            ),
          ),
        ));
  }
}
