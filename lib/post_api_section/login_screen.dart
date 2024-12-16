import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void signup(String email, String password) async {
    print('button hit');

    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('post api repose is $data');
        print('successfully signup');
      } else {
        print('falied to  signup');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('LOGIN SCREEN'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: 'email',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  signup(emailcontroller.text.toString(),
                      passwordcontroller.text.toString());
                },
                child: Center(
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(child: Text('sign up')),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
