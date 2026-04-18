import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab9_12/screens/makeCoffeeScreen.dart';

// Переиспользуем цвета из makeCoffeeScreen
const _kDarkBrown = Color(0xFF3E2723);
const _kMedBrown = Color(0xFF6D4C41);
const _kLightBrown = Color(0xFFBCAAA4);
const _kCream = Color(0xFFFFF8F0);
const _kBeige = Color(0xFFD7CCC8);

class AddResourceScreen extends StatefulWidget {
  const AddResourceScreen({super.key});

  @override
  State<AddResourceScreen> createState() => _AddResourceScreenState();
}

class _AddResourceScreenState extends State<AddResourceScreen> {
  final textControllerMilk = TextEditingController();
  final textControllerWater = TextEditingController();
  final textControllerBeans = TextEditingController();
  final textControllerCash = TextEditingController();

  void addResources() {
    setState(() {
      machine.res.addCash(int.tryParse(textControllerCash.text) ?? 0);
      machine.res.addCoffee(int.tryParse(textControllerBeans.text) ?? 0);
      machine.res.addWater(int.tryParse(textControllerWater.text) ?? 0);
      machine.res.addMilk(int.tryParse(textControllerMilk.text) ?? 0);
      textControllerMilk.clear();
      textControllerWater.clear();
      textControllerBeans.clear();
      textControllerCash.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kCream,
      child: ListView(
        children: [
          // Панель с текущим состоянием ресурсов
          Container(
            width: double.infinity,
            color: _kMedBrown,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: _kCream,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      const Text(
                        'Текущие ресурсы',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _kDarkBrown,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _resourceRow(Icons.water_drop, 'Молоко', machine.res.milk, 'мл'),
                      _resourceRow(Icons.opacity, 'Вода', machine.res.water, 'мл'),
                      _resourceRow(Icons.coffee, 'Зёрна', machine.res.coffee, 'г'),
                      _resourceRow(Icons.attach_money, 'Деньги', machine.res.cash, '₽'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Заголовок секции ввода
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Добавить ресурсы',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _kDarkBrown,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _inputField(Icons.water_drop, 'Молоко (мл)', textControllerMilk),
          _inputField(Icons.opacity, 'Вода (мл)', textControllerWater),
          _inputField(Icons.coffee, 'Зёрна (г)', textControllerBeans),
          _inputField(Icons.attach_money, 'Деньги (₽)', textControllerCash),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: addResources,
              icon: const Icon(Icons.add, color: _kCream),
              label: const Text(
                'Пополнить',
                style: TextStyle(color: _kCream, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _kDarkBrown,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _resourceRow(IconData icon, String label, int value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: [
          Icon(icon, color: _kMedBrown, size: 20),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(fontSize: 16, color: _kDarkBrown),
          ),
          const Spacer(),
          Text(
            '$value $unit',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _kDarkBrown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(IconData icon, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        style: const TextStyle(color: _kDarkBrown),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: _kMedBrown),
          hintText: hint,
          hintStyle: const TextStyle(color: _kLightBrown),
          filled: true,
          fillColor: _kBeige.withOpacity(0.4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _kLightBrown),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _kMedBrown, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _kLightBrown),
          ),
        ),
      ),
    );
  }
}
