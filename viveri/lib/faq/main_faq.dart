import 'package:flutter/material.dart';
import 'package:viveri/login_page.dart';
import 'faq_tela.dart'; // onde está sua classe FaqTela
import 'question_model/faq_utils.dart'; // onde está tempoRelativo() e configurarTimeago()
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configurarTimeago(); // define o locale pt_br para o timeago

  // Verifica se o usuário está logado e pega o token (opcionalmente, pode redireciar para tela de login)
  final authService = AuthService();
  final token = await authService.getToken();

  if (token == null) runApp(const LoginPage());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ajuste temporário para testes:
    const currentUserId = "1";
    const isDono = true;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FaqTela(currentUser: currentUserId, isDono: isDono),
    );
  }
}
