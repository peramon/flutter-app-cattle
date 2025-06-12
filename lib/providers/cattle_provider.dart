import 'package:flutter/material.dart';
import '../models/cow.dart';

class CattleProvider with ChangeNotifier {
  final List<Cow> _cattle = [
    Cow(breed: 'Holstein', weight: '350', age: '2', status: 'Saludable'),
    Cow(breed: 'Normando', weight: '410', age: '3', status: 'Enfermo'),
  ];

  List<Cow> get cattle => [..._cattle];

  void addCow(Cow cow) {
    _cattle.add(cow);
    notifyListeners(); // actualiza los widgets
  }

  Future<bool> uploadCowAutomatically() async {
    await Future.delayed(const Duration(seconds: 5));

    _cattle.addAll([
      Cow(breed: 'Holstein', weight: '370', age: '3', status: 'Enfermo'),
      Cow(breed: 'Normando', weight: '390', age: '4', status: 'Saludable'),
    ]);

    notifyListeners();
    return true;
  }
}
