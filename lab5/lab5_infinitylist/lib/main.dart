import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список элементов',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Список элементов'),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Text('строка $index');
            
          },
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }
}
