import 'dart:convert';

import 'package:api_practice/get_api_section/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class complex_json extends StatefulWidget {
  const complex_json({super.key});

  @override
  State<complex_json> createState() => _complex_jsonState();
}

class _complex_jsonState extends State<complex_json> {
  // api response start with object so we dont need to create list
  Future<products_model> getProducts() async {
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/f8b594e4-1bcf-4a01-bb78-791f54333e6f'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return products_model.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Complex Json'),
        ),
        body: FutureBuilder<products_model>(
            future: getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(
                  child: Text('NO DATA FOUND '),
                );
              } else {
                var productItems = snapshot.data!.data!;
                return ListView.builder(
                    itemCount: productItems.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot
                                      .data!.data![index].images!.length,
                                  itemBuilder: (context, position) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data![index]
                                              .images![position]
                                              .url
                                              .toString()),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ],
                      );
                    });
              }
            }),
      ),
    );
  }
}
