import '../async/methods.dart';
import 'Enums.dart';
import 'package:lab9_12/classes/Machine.dart';

abstract class ICoffee {
  int milk();
  int coffeBeans();
  int water();
  int cash();
}

class CoffeeAmericano implements ICoffee {
  final type = CoffeeType.Americano;
  @override
  int cash() => 80;
  @override
  int coffeBeans() => 50;
  @override
  int milk() => 0;
  @override
  int water() => 100;
  @override
  String toString() {
    return 'Американо';
  }
}

class CoffeeEspresso implements ICoffee {
  final type = CoffeeType.Espresso;
  @override
  int cash() => 120;
  @override
  int coffeBeans() => 30;
  @override
  int milk() => 250;
  @override
  int water() => 50;
  @override
  String toString() {
    return 'Эспрессо';
  }
}

class CoffeeCappucino implements ICoffee {
  final type = CoffeeType.Cappucino;
  @override
  int cash() => 150;
  @override
  int coffeBeans() => 50;
  @override
  int milk() => 140;
  @override
  int water() => 30;
  @override
  String toString() {
    return 'Каппучино';
  }
}
