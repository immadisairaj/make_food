import 'package:flutter/material.dart';
import 'package:make_food/crusine.dart';
import 'package:make_food/extensions.dart';
import 'package:make_food/food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Crusine crusineDropdown = Crusine.any;
  String crusine = '';
  String food = '';
  bool isVegetarian = false;

  submit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodPage(
          crusine: crusineDropdown == Crusine.custom
              ? crusine
              : crusineDropdown.name,
          food: food,
          isVegetarian: isVegetarian,
        ),
      ),
    );
  }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Select Crusine'),
                    DropdownButton<Crusine>(
                      value: crusineDropdown,
                      onChanged: (Crusine? newValue) {
                        setState(() {
                          crusineDropdown = newValue!;
                        });
                      },
                      items: Crusine.values.map((Crusine crusine) {
                        return DropdownMenuItem<Crusine>(
                            value: crusine,
                            child: Text(crusine.name.toString()));
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (crusineDropdown == Crusine.custom)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Enter custom crusine',
                      ),
                      maxLength: 23,
                      textInputAction: TextInputAction.next,
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
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) => submit(),
                    onChanged: (value) {
                      food = value;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submit,
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
