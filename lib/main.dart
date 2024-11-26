import 'package:antrian_app/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'core/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antrian: Aplikasi Pengelola Antrian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: AppColors.primary,
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColors.white,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
