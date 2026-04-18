import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Возвращение значения', style: const TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.pushNamed(context, 'Второе окно');
              },
              child: const Text(
                'Открыть второе окно',
                style: const TextStyle(color: Colors.white),
              )),
        ],
      )),
    );
  }
}

class SecondScreen extends StatelessWidget {
  String yes = 'Да';
  String no = 'Нет';
  String id1;
  SecondScreen({String id = ""}) : id1 = id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue, title: const Text('Выберите вариант', style: TextStyle(color: Colors.white))),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(yes),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  yes,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                )),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(no),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  no,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                )),
          ])),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => const MainScreen(),
      'Второе окно': (BuildContext context) => SecondScreen()
    },
    onGenerateRoute: (routeSettings) {
      var path = routeSettings.name!.split('/');
      if (path[1] == "Второе окно") {
        return MaterialPageRoute(
          builder: (context) => SecondScreen(id: path[2]),
          settings: routeSettings,
        );
      }
    },
  ));
}
