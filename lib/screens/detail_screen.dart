import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../models/point_of_sale.dart';
import '../providers/point_of_sale_provider.dart';
import 'add_edit_screen.dart';

class DetailScreen extends StatefulWidget {
  final PointOfSale pointOfSale;

  const DetailScreen({super.key, required this.pointOfSale});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Function to launch URLs
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el enlace: ${url.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pointOfSale = widget.pointOfSale;
    final serialNumbers = pointOfSale.serialNumbers.split(',');
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
            _buildInfoCard('Información General', [
              _buildListTile(Icons.calendar_today, 'Fecha', pointOfSale.date),
              _buildListTile(Icons.person, 'Dueño', pointOfSale.owner),
               _buildListTile(Icons.phone, 'Teléfono', pointOfSale.phone),
              _buildListTile(
                  Icons.location_on,
                  'Dirección',
                  '${pointOfSale.address}, ${pointOfSale.city}, ${pointOfSale.state} ${pointOfSale.zipCode}'),
              _buildListTile(Icons.confirmation_number, 'Cantidad de Placas',
                  pointOfSale.plateQuantity.toString()),
            ]),
            _buildInfoCard(
                'Números de Serie',
                serialNumbers
                    .map((sn) => _buildListTile(Icons.chevron_right, 'SN', sn))
                    .toList()),
            _buildInfoCard(
                'Visitas',
                visits
                    .where((v) => v.isNotEmpty)
                    .map((v) => _buildListTile(
                        Icons.calendar_today_outlined, 'Fecha', v))
                    .toList()),
            _buildInfoCard('Información Adicional', [
              _buildListTile(Icons.price_change, 'Precio',
                  '\$${pointOfSale.price.toStringAsFixed(2)}'),
              if (pointOfSale.notes != null && pointOfSale.notes!.isNotEmpty)
                _buildListTile(Icons.note, 'Notas', pointOfSale.notes!),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
