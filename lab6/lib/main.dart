import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        appBar: AppBar(
          title: const Text('Калькулятор площади', style: TextStyle(color: Colors.white),),
          backgroundColor: const Color.fromARGB(255, 57, 84, 160),
        ),
        body: const MyForm())));

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final formKey = GlobalKey<FormState>();
  int width = 0;
  int height = 0;
  int area = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(children: <Widget>[
          const Text(
            'Ширина (мм): ',
            style: TextStyle(fontSize: 20.0),
          ),
          TextFormField(validator: (value) {
            if (value!.isEmpty) return 'Введите ширину';
            try {
              width = int.parse(value);
            } catch (e) {
              width = 0;
              return e.toString();
            }
          }),
          const SizedBox(height: 20.0),
          const Text(
            'Высота (мм): ',
            style: TextStyle(fontSize: 20.0),
          ),
          TextFormField(validator: (value) {
            if (value!.isEmpty) return 'Введите высоту';
            try {
              height = int.parse(value);
            } catch (e) {
              height = 0;
              return e.toString();
            }
          }),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  if (width is int && height is int) area = width * height;
                });
              }
            },
            child: const Text('Вычислить', style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 76, 84, 175)),

          ),
          const SizedBox(height: 50.0),
          Text(
            area == 0 ? '' : 'S = $width * $height = $area (мм^2)',
            style: const TextStyle(fontSize: 30.0),
          )
        ]),
      ),
    );
  }
}
