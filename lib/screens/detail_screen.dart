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
    final serialNumbers = pointOfSale.serialNumbers?.split(',') ?? [];
    final visits = pointOfSale.visits?.split(',') ?? [];

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
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Información General', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Fecha'),
                      subtitle: Text(pointOfSale.date),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Dueño'),
                      subtitle: Text(pointOfSale.owner),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Dirección'),
                      subtitle: Text('${pointOfSale.address}, ${pointOfSale.city}, ${pointOfSale.state} ${pointOfSale.zipCode}'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Teléfono'),
                      subtitle: Text(pointOfSale.phone),
                    ),
                    ListTile(
                      leading: const Icon(Icons.confirmation_number),
                      title: const Text('Cantidad de Placas'),
                      subtitle: Text(pointOfSale.plateQuantity.toString()),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Números de Serie', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(),
                    ...serialNumbers.map((sn) => ListTile(leading: const Icon(Icons.chevron_right), title: Text(sn))).toList(),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Visitas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(),
                    ...visits.where((v) => v.isNotEmpty).map((v) => ListTile(leading: const Icon(Icons.calendar_today_outlined), title: Text(v))).toList(),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Información Adicional', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.price_change),
                      title: const Text('Precio'),
                      subtitle: Text('\$${pointOfSale.price.toStringAsFixed(2)}'),
                    ),
                    if (pointOfSale.notes != null && pointOfSale.notes!.isNotEmpty)
                      ListTile(
                        leading: const Icon(Icons.note),
                        title: const Text('Notas'),
                        subtitle: Text(pointOfSale.notes!),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
