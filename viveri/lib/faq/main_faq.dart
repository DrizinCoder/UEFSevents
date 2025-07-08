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

// Versão que não Mocka as perguntas/respostas, só consome a Api
// import 'package:flutter/material.dart';
// import 'package:viveri/login_page.dart';
// import 'package:viveri/faq/faq_tela.dart';
// import 'package:viveri/faq/question_model/faq_utils.dart';
// import 'package:viveri/faq/services/auth_service.dart';
// import 'dart:convert';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   configurarTimeago();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AuthWrapper(),
//     );
//   }
// }

// class AuthWrapper extends StatefulWidget {
//   const AuthWrapper({super.key});

//   @override
//   State<AuthWrapper> createState() => _AuthWrapperState();
// }

// class _AuthWrapperState extends State<AuthWrapper> {
//   final AuthService _authService = AuthService();
//   bool _loading = true;
//   String? _userId;
//   bool _isDono = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkAuth();
//   }

//   Future<void> _checkAuth() async {
//     final token = await _authService.getToken();

//     if (token != null) {
//       try {
//         final parts = token.split('.');
//         if (parts.length != 3) throw Exception('Token inválido');

//         final payload = base64.normalize(parts[1]);
//         final decoded = utf8.decode(base64Url.decode(payload));
//         final payloadMap = jsonDecode(decoded);

//         setState(() {
//           _userId = payloadMap['user_id'].toString();
//           _isDono = payloadMap['user_type'] == 'fugleman';
//           _loading = false;
//         });
//       } catch (_) {
//         setState(() => _loading = false);
//       }
//     } else {
//       setState(() => _loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (_userId != null) {
//       return FaqTela(currentUser: _userId!, isDono: _isDono);
//     }

//     return const LoginPage();
//   }
// }
