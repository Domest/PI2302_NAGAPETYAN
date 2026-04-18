import 'package:flutter/material.dart';
import '../async/methods.dart';
import 'Coffee.dart';
import 'Resources.dart';

class Machine {
  final res = Resources(0, 0, 0, 0);
  ICoffee? ctype;

  ICoffee cof(ICoffee coffee) {
    return ctype = coffee;
  }

  bool isAvailableRes() {
    if (ctype == null) return false;
    return res.coffee >= ctype!.coffeBeans() &&
        res.water >= ctype!.water() &&
        res.cash >= ctype!.cash() &&
        res.milk >= ctype!.milk();
  }

  /// Возвращает сообщение о нехватке ресурсов или null, если всего хватает
  String? missingResourcesMessage() {
    if (ctype == null) return 'Тип кофе не выбран';
    List<String> missing = [];
    if (res.coffee < ctype!.coffeBeans()) {
      missing.add('зёрен (нужно ${ctype!.coffeBeans()}, есть ${res.coffee})');
    }
    if (res.water < ctype!.water()) {
      missing.add('воды (нужно ${ctype!.water()}, есть ${res.water})');
    }
    if (res.milk < ctype!.milk()) {
      missing.add('молока (нужно ${ctype!.milk()}, есть ${res.milk})');
    }
    if (res.cash < ctype!.cash()) {
      missing.add('денег (нужно ${ctype!.cash()}, есть ${res.cash})');
    }
    if (missing.isEmpty) return null;
    return 'Недостаточно: ${missing.join('; ')}';
  }

  void subStractRes() {
    res.setMilk = res.milk - ctype!.milk();
    res.setWater = res.water - ctype!.water();
    res.setCash = res.cash - ctype!.cash();
    res.setCoffee = res.coffee - ctype!.coffeBeans();
  }

  /// Возвращает null при успехе, или строку с ошибкой
  String? makeCoffeeByType(String? type) {
    if (type == null) return 'Тип кофе не выбран';
    // toNewString() возвращает имя enum: 'Americano', 'Espresso', 'Cappucino'
    // toLowerCase() даёт: 'americano', 'espresso', 'cappucino'
    switch (type.toLowerCase()) {
      case 'americano':
        cof(CoffeeAmericano());
        break;
      case 'cappucino':
        cof(CoffeeCappucino());
        break;
      case 'espresso':
        cof(CoffeeEspresso());
        break;
      default:
        return 'Неизвестный тип кофе: $type';
    }

    final error = missingResourcesMessage();
    if (error != null) return error;

    subStractRes();
    return null;
  }
}
