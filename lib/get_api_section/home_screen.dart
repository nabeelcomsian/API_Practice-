import 'dart:convert';

import 'package:api_practice/get_api_section/models/my_first_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHome extends StatelessWidget {
  MyHome({super.key});

  List<MyFirstModel> modelList = [];

  Future<List<MyFirstModel>> mymodel() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      modelList.clear();
      for (var item in data) {
        // Ensure each item is cast to Map<String, dynamic>
        modelList.add(MyFirstModel.fromJson(item as Map<String, dynamic>));
      }
      return modelList;
    } else {
      return modelList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("API PRACTICE"),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Text("MODEL LIST ITEMS "),
            Expanded(
              child: FutureBuilder(
                  future: mymodel(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("Data Is Loading"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: modelList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Tittle\n' +
                                          modelList[index].title.toString()),
                                      Text('Body\n' +
                                          modelList[index].body.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
