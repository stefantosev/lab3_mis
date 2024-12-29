import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JokeProvider with ChangeNotifier {
  final Set<String> _favorites = {};

  Set<String> get favorites => _favorites;


  /// Додава шега во омилените.
  Future<void> addFavorite(String setup, String punchline) async {
    if (!_favorites.contains(setup)) {
      _favorites.add(setup);

      // Додај во Firestore.
      await FirebaseFirestore.instance.collection('favorites').add({
        'setup': setup,
        'punchline': punchline,
        'timestamp': FieldValue.serverTimestamp(),
      });

      notifyListeners();
    }
  }

  /// Отстранува шега од омилените.
  Future<void> removeFavorite(String setup) async {
    if (_favorites.contains(setup)) {
      _favorites.remove(setup);

      // Отстрани од Firestore.
      final querySnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('setup', isEqualTo: setup)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      notifyListeners();
    }
  }

  /// Проверува дали шега е омилена.
  bool isFavorite(String setup) {
    return _favorites.contains(setup);
  }

  /// Презема омилените шеги од Firestore.
  Future<void> loadFavorites() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('favorites').get();

    for (var doc in querySnapshot.docs) {
      _favorites.add(doc['setup']);
    }


    notifyListeners();
  }
}