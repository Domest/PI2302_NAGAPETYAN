class Resources {
  int _coffeBeans;
  int _milk;
  int _water;
  int _cash;
  Resources(this._coffeBeans, this._milk, this._water, this._cash);

  int get milk => _milk;
  int get coffee => _coffeBeans;
  int get water => _water;
  int get cash => _cash;

  set setMilk(int num) => (num >= 0 ? _milk = num : _milk = _milk);
  set setCoffee(int num) =>
      (num >= 0 ? _coffeBeans = num : _coffeBeans = _coffeBeans);
  set setWater(int num) => (num >= 0 ? _water = num : _water = _water);
  set setCash(int num) => (num >= 0 ? _cash = num : _cash = _cash);

  void addMilk(int num) {
    _milk = milk + num;
  }

  void addCoffee(int num) {
    _coffeBeans = coffee + num;
  }

  void addWater(int num) {
    _water = water + num;
  }

  void addCash(int num) {
    _cash = cash + num;
  }

  @override
  String toString() {
    return 'зерна: $_coffeBeans молоко: $_milk вода: $_water деньги: $_cash';
  }
}
