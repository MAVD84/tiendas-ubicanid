import 'package:flutter/material.dart';
import '../models/point_of_sale.dart';
import '../database_helper.dart';

class PointOfSaleProvider with ChangeNotifier {
  List<PointOfSale> _pointsOfSale = [];
  List<PointOfSale> _filteredPointsOfSale = [];

  List<PointOfSale> get pointsOfSale => _filteredPointsOfSale;

  Future<void> loadPointsOfSale() async {
    _pointsOfSale = await DatabaseHelper.instance.readAll();
    _filteredPointsOfSale = _pointsOfSale;
    notifyListeners();
  }

  Future<void> addPointOfSale(PointOfSale pointOfSale) async {
    await DatabaseHelper.instance.create(pointOfSale);
    await loadPointsOfSale();
  }

  Future<void> updatePointOfSale(PointOfSale pointOfSale) async {
    await DatabaseHelper.instance.update(pointOfSale);
    await loadPointsOfSale();
  }

  Future<void> deletePointOfSale(int id) async {
    await DatabaseHelper.instance.delete(id);
    await loadPointsOfSale();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredPointsOfSale = _pointsOfSale;
    } else {
      _filteredPointsOfSale = _pointsOfSale
          .where((pos) =>
              pos.business.toLowerCase().contains(query.toLowerCase()) ||
              pos.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
