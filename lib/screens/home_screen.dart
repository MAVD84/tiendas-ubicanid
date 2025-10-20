import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/point_of_sale_provider.dart';
import '../widgets/point_of_sale_list.dart';
import '../widgets/search_bar.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PointOfSaleProvider>(context, listen: false).loadPointsOfSale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubican ID Tiendas'),
      ),
      body: Column(
        children: [
          const SearchBarWidget(),
          Expanded(
            child: Consumer<PointOfSaleProvider>(
              builder: (context, provider, child) {
                return PointOfSaleList(pointsOfSale: provider.pointsOfSale);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
