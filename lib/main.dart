import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/point_of_sale_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PointOfSaleProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light();

        return MaterialApp(
          title: 'Ubican ID Tiendas',
          theme: theme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
