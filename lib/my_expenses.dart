import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_despesas/screen/homepage_tab_screen.dart';

class MyExpenses extends StatelessWidget {
  const MyExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 119, 101, 255),
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: HomePageTab(),
    );
  }
}
