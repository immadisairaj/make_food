import 'package:flutter/material.dart';
import 'package:make_food/generative_food.dart';
import 'package:make_food/injection_container.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({
    super.key,
    required this.foodType,
    required this.food,
    required this.isVegetarian,
  });

  final String foodType;
  final String food;
  final bool isVegetarian;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe ($foodType - $food)'),
      ),
      body: FutureBuilder(
        future: getIt<GenerativeFood>().makeFood(
          foodType,
          food,
          isVegetarian: isVegetarian,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error getting your recipe :('
                  '\nLog: ${snapshot.error.toString()}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final food = snapshot.data;
          return Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      food!.item,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Ingredients:',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: food.ingredients.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '${index + 1}. ${food.ingredients[index]}',
                          style: const TextStyle(fontSize: 16),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Steps to Prepare:',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: food.procedure.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '${index + 1}. ${food.procedure[index]}',
                          style: const TextStyle(fontSize: 16),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
