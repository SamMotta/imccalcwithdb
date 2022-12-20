import 'package:flutter/material.dart';
import 'package:imccalc/Repositories/SQLite/database.dart';
import 'package:imccalc/pages/calculator_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SQLiteDataBase().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IMCCalculatorPage(),
    );
  }
}

