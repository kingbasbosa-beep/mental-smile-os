import 'package:flutter/material.dart';
import 'features/specialists/presentation/specialists_categories_page.dart';

void main() {
  runApp(const SpecialistsPreviewApp());
}

class SpecialistsPreviewApp extends StatelessWidget {
  const SpecialistsPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Specialists Preview',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: null,
      ),
      home: const SpecialistsCategoriesPage(),
    );
  }
}
