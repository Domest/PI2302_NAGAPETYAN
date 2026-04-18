import 'dart:async';

Future<void> waterHeating() async {
  print('Греем воду');
  var waitingFuture = Future<Object?>.delayed(const Duration(seconds: 3));
  await waitingFuture.then((_) => print('Вода горячая'));
}

Future<void> coffeeMaking() async {
  print('Варим кофе');
  var waitingFuture = Future<Object?>.delayed(const Duration(seconds: 5));
  await waitingFuture.then((_) => print('Кофе сварено'));
}

Future<void> milkShaking() async {
  print('Добавляем молоко');
  var waitingFuture = Future<Object?>.delayed(const Duration(seconds: 5));
  await waitingFuture.then((_) => print('Молоко добавлено'));
}

Future<void> gathering() async {
  print('Последние штрихи');
  var waitingFuture = Future<Object?>.delayed(const Duration(seconds: 3));
  await waitingFuture.then((_) => print('Кофе готов!'));
}
