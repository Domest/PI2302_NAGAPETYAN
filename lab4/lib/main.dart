import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГау',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Общежития КубГАУ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool likeState = false;
  int likeCount = 0;
  void likeReact() {
    setState(() {
      if (likeState) {
        likeCount--;
        likeState = !likeState;
      } else {
        likeCount++;
        likeState = !likeState;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("/images/общага.jpg", fit: BoxFit.fill),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text('Общежитие №20',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                '',
                                style: TextStyle(fontSize: 8),
                              ),
                              Text(
                                'Краснодар, ул. Калинина, 13',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: likeReact,
                                icon: Icon(
                                  Icons.favorite,
                                  color: likeState
                                      ? Colors.red[500]
                                      : Colors.grey[500],
                                ),
                              ),
                              Text('$likeCount'),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => launch("tel://+78612215942"),
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.green[500],
                                ),
                              ),
                              Text(
                                'Позвонить',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => launch(
                                    'https://www.google.com/maps/search/?api=1&query=45.05030994296792,38.92070860447134'),
                                icon: Icon(
                                  Icons.near_me,
                                  color: Colors.green[500],
                                ),
                              ),
                              Text(
                                'Маршрут',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => Share.share(
                                    'https://www.google.com/maps/search/?api=1&query=45.05030994296792,38.92070860447134'),
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.green[500],
                                ),
                              ),
                              Text(
                                'ПОДЕЛИТЬСЯ',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях университета, при поселении между администрацией и студентами заключается договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
