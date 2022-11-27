import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import "../models/user_model.dart";

class UserAPIPage extends StatefulWidget {
  const UserAPIPage({super.key});

  @override
  State<UserAPIPage> createState() => _UserAPIPageState();
}

class _UserAPIPageState extends State<UserAPIPage> {
  // create a list of Maps that we have inside the response of the API
  List<UserModel> _userModelList = [];

  // create a future function that will return list of maps using api response.
  Future<List<UserModel>> getUserModel() async {
    // grap the api response
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    // check the response of the api is valid or not
    if (response.statusCode == 200) {
      // create a jsonData variable
      final jsonData = jsonDecode(response.body.toString());

      // append each single map into the list
      for (Map<String, dynamic> map in jsonData) {
        _userModelList.add(UserModel.fromJson(map));
      }

      return _userModelList;
    } else {
      throw Exception("Invalid response from API");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: FutureBuilder(
          future: getUserModel(),
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            return ListView.builder(
              itemCount: _userModelList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      getRow(
                        "Id",
                        _userModelList[index].id.toString(),
                      ),
                      getRow(
                        "Name",
                        _userModelList[index].name.toString(),
                      ),
                      getRow(
                        "Username",
                        _userModelList[index].username.toString(),
                      ),
                      getRow(
                        "Email",
                        _userModelList[index].email.toString(),
                      ),

                      // Address
                    ],
                  ),
                );
              },
            );
          },
        )),
      ],
    );
  }
}

Widget getRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    ),
  );
}
