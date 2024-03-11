import 'package:flutter/material.dart';
import 'package:make_food/generative_food.dart';
import 'package:make_food/injection_container.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({
    super.key,
    required this.crusine,
    required this.food,
    required this.isVegetarian,
  });

  final String crusine;
  final String food;
  final bool isVegetarian;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe ($crusine - $food)'),
      ),
      body: FutureBuilder(
        future: getIt<GenerativeFood>().makeFood(
          crusine,
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
                        final content = food.ingredients[index];
                        final isTitle = content.contains('For the') &&
                            content.contains(':');
                        return ListContent(isTitle: isTitle, content: content);
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
                        final content = food.procedure[index];
                        final isTitle = content.contains('To make') &&
                            content.contains(':');
                        return ListContent(isTitle: isTitle, content: content);
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

class ListContent extends StatelessWidget {
  const ListContent({
    super.key,
    required this.isTitle,
    required this.content,
  });

  final bool isTitle;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isTitle)
          const Text(
            '- ',
            style: TextStyle(fontSize: 16),
          ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTitle ? FontWeight.bold : null,
            ),
          ),
        ),
      ],
    );
  }
}
