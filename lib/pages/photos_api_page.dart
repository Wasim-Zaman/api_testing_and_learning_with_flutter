import 'dart:convert';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class PhotosAPIPage extends StatefulWidget {
  const PhotosAPIPage({super.key});

  @override
  State<PhotosAPIPage> createState() => _PhotosAPIPageState();
}

class _PhotosAPIPageState extends State<PhotosAPIPage> {
  // create a list of photos
  final List<Photos> photos = [];

  // create a future method that will return list of photos from API
  Future<List<Photos>> getPhotos() async {
    // get a responce from the API request
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

    // check if the response is successful
    if (response.statusCode == 200) {
      // parse the response body
      final data = jsonDecode(response.body.toString());

      // loop through the data and create a list of photos
      for (final map in data) {
        Photos photo = Photos(
          url: map['url'],
          title: map['title'],
          thumbnailUrl: map['thumbnailUrl'],
        );

        photos.add(photo);
      }

      return photos;
    } else {
      throw Exception("Failed to load photos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPhotos(),
      builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].title.toString()),
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(snapshot.data![index].url.toString()),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Photos {
  String title, url, thumbnailUrl;

  Photos({
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });
}
