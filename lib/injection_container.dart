import 'package:get_it/get_it.dart';
import 'package:make_food/generative_food.dart';

/// get all registered injection containers
final getIt = GetIt.instance;

/// Register all the dependencies
void setUp() {
  getIt.registerSingleton<GenerativeFood>(GenerativeFood());
}
