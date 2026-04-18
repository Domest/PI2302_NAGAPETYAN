import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhotoGallery(),
    );
  }
}

class PhotoGallery extends StatefulWidget {
  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  List<dynamic> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      setState(() {
        photos = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Фотогалерея',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        photos[index]['url'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          photos[index]['title'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}