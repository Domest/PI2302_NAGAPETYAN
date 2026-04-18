import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab9_12/classes/Machine.dart';
import 'package:lab9_12/classes/Enums.dart';
import 'package:lab9_12/async/methods.dart';

class MakeCoffeeScreen extends StatefulWidget {
  const MakeCoffeeScreen({super.key});

  @override
  State<MakeCoffeeScreen> createState() => _MakeCoffeeScreenState();
}

Machine machine = Machine();

// Кофейная палитра цветов
const kDarkBrown = Color(0xFF3E2723);
const kMedBrown = Color(0xFF6D4C41);
const kLightBrown = Color(0xFFBCAAA4);
const kCream = Color(0xFFFFF8F0);
const kBeige = Color(0xFFD7CCC8);

class _MakeCoffeeScreenState extends State<MakeCoffeeScreen> {
  CoffeeType? coffeeType = CoffeeType.Americano;
  final textController = TextEditingController();
  String? errorText;
  bool _isBrewing = false;

  void _showMessage(String text, int duration) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: const TextStyle(color: kCream)),
        backgroundColor: kDarkBrown,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _onChanged(String text) {
    setState(() {
      errorText = (text == '' || text == '0') ? 'Не забудьте положить деньги' : null;
    });
  }

  void _addCash() {
    final val = int.tryParse(textController.text);
    if (val == null || val == 0) {
      setState(() => errorText = 'Введите сумму больше нуля');
      return;
    }
    setState(() {
      machine.res.addCash(val);
      textController.text = '';
      errorText = null;
    });
  }

  Future<void> _onBrew() async {
    if (_isBrewing) return;
    final errorMsg = machine.makeCoffeeByType(coffeeType!.toNewString());
    if (errorMsg != null) {
      _showMessage(errorMsg, 4);
      return;
    }
    setState(() => _isBrewing = true);

    _showMessage('Греем воду...', 3);
    await waterHeating();

    _showMessage('Варим кофе...', 5);
    await coffeeMaking();

    _showMessage('Добавляем молоко...', 5);
    await milkShaking();

    _showMessage('Последние штрихи...', 3);
    await gathering();

    setState(() => _isBrewing = false);
    _showMessage('☕ Кофе готов! Приятного!', 4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kCream,
      child: ListView(children: [
        Column(
          children: [
            _resourcePanel(),
            _radioPickerWidget(),
            const Divider(color: kLightBrown, thickness: 1),
            const SizedBox(height: 16),
            _cashInputWidget(),
            const SizedBox(height: 16),
          ],
        ),
      ]),
    );
  }

  Widget _resourcePanel() {
    return Container(
      width: double.infinity,
      color: kMedBrown,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          _resourceRow(Icons.coffee, 'Зёрна', machine.res.coffee, 'г'),
          _resourceRow(Icons.water_drop, 'Молоко', machine.res.milk, 'мл'),
          _resourceRow(Icons.opacity, 'Вода', machine.res.water, 'мл'),
          const SizedBox(height: 10),
          _machineWindow(),
        ],
      ),
    );
  }

  Widget _resourceRow(IconData icon, String label, int value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: kBeige, size: 18),
          const SizedBox(width: 8),
          Text(
            '$label: $value $unit',
            style: const TextStyle(color: kCream, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _machineWindow() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: kCream,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.coffee_maker, size: 48, color: kMedBrown),
          const SizedBox(height: 12),
          const Text(
            'Кофе-машина',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: kDarkBrown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Доступно средств: ${machine.res.cash} ₽',
            style: TextStyle(fontSize: 16, color: kMedBrown),
          ),
          if (_isBrewing) ...[
            const SizedBox(height: 12),
            const SizedBox(
              width: 24, height: 24,
              child: CircularProgressIndicator(
                color: kMedBrown,
                strokeWidth: 2.5,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _radioPickerWidget() {
    return Stack(children: [
      Container(
        color: kCream,
        height: 170,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _coffeeListTile('Американо', CoffeeType.Americano, '80 ₽ · зёрна 50г · вода 100мл'),
            _coffeeListTile('Каппучино', CoffeeType.Cappucino, '150 ₽ · зёрна 50г · молоко 140мл · вода 30мл'),
            _coffeeListTile('Эспрессо', CoffeeType.Espresso, '120 ₽ · зёрна 30г · молоко 250мл · вода 50мл'),
          ],
        ),
      ),
      Positioned(
        right: 16,
        bottom: 8,
        child: FloatingActionButton(
          backgroundColor: _isBrewing ? kLightBrown : kDarkBrown,
          onPressed: _isBrewing ? null : _onBrew,
          tooltip: 'Сварить кофе',
          child: _isBrewing
              ? const SizedBox(
                  width: 22, height: 22,
                  child: CircularProgressIndicator(color: kCream, strokeWidth: 2),
                )
              : const Icon(Icons.play_arrow, color: kCream, size: 30),
        ),
      ),
    ]);
  }

  ListTile _coffeeListTile(String title, CoffeeType value, String subtitle) {
    final selected = coffeeType == value;
    return ListTile(
      tileColor: selected ? kBeige : null,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: kDarkBrown,
        ),
      ),
      subtitle: Text(subtitle, style: TextStyle(color: kMedBrown, fontSize: 12)),
      leading: Radio<CoffeeType>(
        groupValue: coffeeType,
        value: value,
        activeColor: kDarkBrown,
        onChanged: _isBrewing
            ? null
            : (CoffeeType? val) => setState(() => coffeeType = val),
      ),
    );
  }

  Widget _cashInputWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: _onChanged,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: textController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: kDarkBrown),
              decoration: InputDecoration(
                errorText: errorText,
                hintText: 'Внести деньги (₽)',
                hintStyle: TextStyle(color: kLightBrown),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kMedBrown),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kLightBrown),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _addCash,
            icon: const Icon(Icons.add_circle, color: kDarkBrown, size: 30),
            tooltip: 'Внести деньги',
          ),
        ],
      ),
    );
  }
}
