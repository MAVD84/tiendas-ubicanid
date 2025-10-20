import 'package:flutter/material.dart';
import '../models/point_of_sale.dart';
import '../screens/detail_screen.dart';

class PointOfSaleList extends StatelessWidget {
  final List<PointOfSale> pointsOfSale;

  const PointOfSaleList({super.key, required this.pointsOfSale});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pointsOfSale.length,
      itemBuilder: (context, index) {
        final pos = pointsOfSale[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(pos.business, style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text(pos.city),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailScreen(pointOfSale: pos),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
