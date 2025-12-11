import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  static Future<void> toggleFavorite(int productId, String listKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'favorites_$listKey';
    List<String> favorites = prefs.getStringList(key) ?? [];

    if (favorites.contains(productId.toString())) {
      favorites.remove(productId.toString());
    } else {
      favorites.add(productId.toString());
    }

    await prefs.setStringList(key, favorites);
  }

  static Future<bool> isFavorite(int productId, String listKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'favorites_$listKey';
    List<String> favorites = prefs.getStringList(key) ?? [];
    return favorites.contains(productId.toString());
  }

  static Future<List<int>> getFavorites(String listKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'favorites_$listKey';
    List<String> favorites = prefs.getStringList(key) ?? [];
    return favorites.map((e) => int.parse(e)).toList();
  }
}