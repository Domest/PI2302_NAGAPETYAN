enum CoffeeType {
  Americano,
  Espresso,
  Cappucino,
}

extension ParseToString on CoffeeType {
  String toNewString() {
    return toString().split('.').last;
  }
}
