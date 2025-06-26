import 'package:flutter/foundation.dart';
import '../models/model.dart'; // Import your DrinkModel class here

class FavoritesProvider with ChangeNotifier {
  final List<DrinkModel> _favorites = [];

  List<DrinkModel> get favorites => List.unmodifiable(_favorites);

  void toggleFavorite(DrinkModel drink) {
    final exists = _favorites.any((d) => d.id == drink.id);
    if (exists) {
      _favorites.removeWhere((d) => d.id == drink.id);
    } else {
      _favorites.add(drink);
    }
    notifyListeners();
  }

  bool isFavorite(DrinkModel drink) {
    return _favorites.any((d) => d.id == drink.id);
  }
}
