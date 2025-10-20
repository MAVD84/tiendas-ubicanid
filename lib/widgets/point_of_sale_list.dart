import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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
            subtitle: Text(pos.owner),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () => _makePhoneCall(pos.phone),
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.whatsapp),
                  onPressed: () => _sendWhatsAppMessage(pos.phone),
                ),
              ],
            ),
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<void> _sendWhatsAppMessage(String phoneNumber) async {
    final Uri launchUri = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}
