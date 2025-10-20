import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/point_of_sale.dart';
import '../providers/point_of_sale_provider.dart';
import 'add_edit_screen.dart';

class DetailScreen extends StatelessWidget {
  final PointOfSale pointOfSale;

  const DetailScreen({super.key, required this.pointOfSale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pointOfSale.business),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddEditScreen(pointOfSale: pointOfSale),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<PointOfSaleProvider>(context, listen: false)
                  .deletePointOfSale(pointOfSale.id!);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Fecha: ${pointOfSale.date}'),
            Text('Dueño: ${pointOfSale.owner}'),
            Text('Dirección: ${pointOfSale.address}'),
            Text('Ciudad: ${pointOfSale.city}'),
            Text('Estado: ${pointOfSale.state}'),
            Text('Código Postal: ${pointOfSale.zipCode}'),
            Text('Teléfono: ${pointOfSale.phone}'),
            Text('Cantidad de Placas: ${pointOfSale.plateQuantity}'),
            Text('Números de Serie: ${pointOfSale.serialNumbers}'),
          ],
        ),
      ),
    );
  }
}
