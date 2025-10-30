import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/role_selection_screen.dart';
import 'providers/delivery_provider.dart';
import 'config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeliveryProvider(),
      child: MaterialApp(
        title: 'GreenGo Logistics',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const RoleSelectionScreen(),
      ),
    );
  }
}
