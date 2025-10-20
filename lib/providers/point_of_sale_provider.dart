import 'package:flutter/material.dart';
import '../models/point_of_sale.dart';
import '../helpers/database_helper.dart';

class PointOfSaleProvider with ChangeNotifier {
  List<PointOfSale> _pointsOfSale = [];
  String _searchQuery = '';

  List<PointOfSale> get pointsOfSale {
    if (_searchQuery.isEmpty) {
      return _pointsOfSale;
    } else {
      return _pointsOfSale
          .where((pos) =>
              pos.business.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              pos.city.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  Future<void> loadPointsOfSale() async {
    _pointsOfSale = await DatabaseHelper.instance.readAll();
    notifyListeners();
  }

  Future<void> addPointOfSale(PointOfSale pointOfSale) async {
    final newPointOfSale = await DatabaseHelper.instance.create(pointOfSale);
    _pointsOfSale.insert(0, newPointOfSale); 
    notifyListeners();
  }

  Future<void> updatePointOfSale(PointOfSale pointOfSale) async {
    await DatabaseHelper.instance.update(pointOfSale);
    final index = _pointsOfSale.indexWhere((pos) => pos.id == pointOfSale.id);
    if (index != -1) {
      _pointsOfSale[index] = pointOfSale;
      notifyListeners();
    } else {
      loadPointsOfSale();
    }
  }

  Future<void> deletePointOfSale(int id) async {
    await DatabaseHelper.instance.delete(id);
    _pointsOfSale.removeWhere((pos) => pos.id == id);
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
