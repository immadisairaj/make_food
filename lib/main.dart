import 'package:flutter/material.dart';
import 'package:make_food/food_page.dart';
import 'package:make_food/injection_container.dart' as di;

void main() {
  di.setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Make Food',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String foodType = '';
  bool isVegetarian = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Food'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Let\'s make some food!'),
            const SizedBox(height: 20),
            // TODO: maybe put a dropdown with type of foods
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter food type',
                ),
                onChanged: (value) {
                  foodType = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Vegetarian:'),
                Switch(
                  value: isVegetarian,
                  onChanged: (value) {
                    setState(() {
                      isVegetarian = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodPage(
                        foodType: foodType, isVegetarian: isVegetarian),
                  ),
                );
              },
              child: const Text('Go!'),
            ),
          ],
        ),
      ),
    );
  }
}
