import 'package:flutter/material.dart';
import 'package:make_food/extensions.dart';
import 'package:make_food/food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String crusine = '';
  String food = '';
  bool isVegetarian = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Food'),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Let\'s make some food!',
                  style: context.titleLarge,
                ),
                const SizedBox(height: 20),
                // TODO: maybe put a dropdown with type of foods
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Crusine',
                    ),
                    maxLength: 23,
                    onChanged: (value) {
                      crusine = value;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Enter food',
                    ),
                    maxLength: 23,
                    onChanged: (value) {
                      food = value;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodPage(
                          crusine: crusine,
                          food: food,
                          isVegetarian: isVegetarian,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Go!',
                    style: context.labelLarge,
                  ),
                ),
              ],
            ),
            Positioned.fill(
              top: 10,
              right: 20,
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Vegetarian:',
                      style: context.titleMedium,
                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
