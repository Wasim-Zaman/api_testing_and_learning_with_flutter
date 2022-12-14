import 'dart:convert';

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:http/http.dart' as http;

import "../models/api_model.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_final_fields
  List<APIModel> _apiModel = [];

  // Create a Future method that will return a list of APIModel objects
  Future<List<APIModel>> fetchAPIModel() async {
    // Create a variable that will hold the response from the API
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    // Check if the response is successful
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      // Loop through the data and create a list of APIModel objects
      for (final item in data) {
        _apiModel.add(APIModel.fromJson(item));
      }
      // Return the list of APIModel objects
      return _apiModel;
    } else {
      // If the response is not successful, throw an error
      throw Exception("Failed to load APIModel");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: fetchAPIModel(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _apiModel.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Title",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(_apiModel[index].title.toString()),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(_apiModel[index].body.toString()),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}
