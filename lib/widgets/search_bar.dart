import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/point_of_sale_provider.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por comercio o ciudad',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) {
          Provider.of<PointOfSaleProvider>(context, listen: false).search(value);
        },
      ),
    );
  }
}
