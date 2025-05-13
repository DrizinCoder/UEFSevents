import 'package:flutter/material.dart';
import 'login_page.dart'; // Certifique-se que o caminho está correto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viveri Login',
      home: LoginPage(),
    );
  }
}
