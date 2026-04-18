import 'package:flutter/material.dart';
import 'dart:math';

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
          padding: const EdgeInsets.only(left: 15, top: 15),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2 ^ $index = ${pow(2, index)}'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Divider(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
