import 'dart:convert';

import 'package:api_practice/get_api_section/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

// ignore: must_be_immutable
class userExample extends StatelessWidget {
  userExample({super.key});
  List<UserModel> userlist = [];
  Future<List<UserModel>> model2() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var item in data) {
        userlist.add(UserModel.fromJson(item as Map<String, dynamic>));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("user model example "),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<UserModel>>(
                  future: model2(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error${snapshot.hasError}"),
                      );
                    } else if (!snapshot.hasData ||
                        (snapshot.data as List).isEmpty) {
                      return const Center(
                        child: Text("NO DATA FOUND "),
                      );
                    } else {
                      var data = snapshot.data as List;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          "Coordinates ${index+1} ${data[index].address.geo.lat}, ${data[index].address.geo.lng} ")
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}


// if there is ssome error in our model map key then we can access apis value without using model using data[index]['address']['geo']['lat']

// import 'dart:convert';

// import 'package:api_practice/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart ' as http;

// // ignore: must_be_immutable
// class userExample extends StatelessWidget {
//   userExample({super.key});

//   var data;
//   Future<void> model2() async {
//     final response =
//         await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

  
//     if (response.statusCode == 200) {
//         data = jsonDecode(response.body.toString());
//     
//      }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("user model example "),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: FutureBuilder(
//                   future: model2(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text("Error${snapshot.hasError}"),
//                       );
//                     // } else if (!snapshot.hasData ||
//                     //     (snapshot.data as List).isEmpty) {
//                     //   return const Center(
//                     //     child: Text("NO DATA FOUND "),
//                     //   );
//                     } else {
                     
//                       return ListView.builder(
//                           itemCount: data.length,
//                           itemBuilder: (context, index) {
//                             return Card(
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                           "Coordinates ${index + 1} ${data[index]['address']['geo']['lat']} ")
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             );
//                           });
//                     }
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



