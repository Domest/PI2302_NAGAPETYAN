import 'package:flutter/material.dart';
import 'package:lab9_12/screens/addResourceScreen.dart';
import 'package:lab9_12/screens/makeCoffeeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофе-машина',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D4C41),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF3E2723),
          foregroundColor: const Color(0xFFFFF8F0),
          title: const Row(
            children: [
              Icon(Icons.coffee_maker, color: Color(0xFFBCAAA4)),
              SizedBox(width: 10),
              Text(
                'Кофе-машина',
                style: TextStyle(
                  color: Color(0xFFFFF8F0),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFFBCAAA4),
            labelColor: Color(0xFFFFF8F0),
            unselectedLabelColor: Color(0xFF8D6E63),
            tabs: [
              Tab(icon: Icon(Icons.coffee_maker), text: 'Сварить'),
              Tab(icon: Icon(Icons.add_circle_outline), text: 'Ресурсы'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [MakeCoffeeScreen(), AddResourceScreen()],
        ),
      ),
    );
  }
}
