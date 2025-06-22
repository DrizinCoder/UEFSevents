import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account_created_page.dart';
import 'login_page.dart';
<<<<<<< Updated upstream
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
=======
>>>>>>> Stashed changes

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

<<<<<<< Updated upstream
Future<Map<String, dynamic>> signupUser({
  required String vat,
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required bool isCPF,
  String? birthDate,
  String? companyName,
  String? respFirstName,
  String? respLastName,
}) async {
  // Limpa o VAT removendo todos os não-números
  final cleanedVat = vat.replaceAll(RegExp(r'[^0-9]'), '');
  
  print('[API] Preparando payload para cadastro...');
  print('[API] VAT limpo: $cleanedVat');
  print('[API] Tipo de usuário: ${isCPF ? "CPF (customer)" : "CNPJ (fugleman)"}');

  final payload = {
    "username": firstName,
    "vat": cleanedVat, // Envia apenas os números
    "email": email,
    "password": password,
    "first_name": firstName,
    "last_name": lastName,
    "phone": "000000000",
    "mobile": "000000000",
    "birth_date": birthDate,
    "user_type": isCPF ? "customer" : "fugleman",
    if (!isCPF) "company_name": companyName,
    // Os campos abaixo são redundantes e podem ser removidos
    // if (isCPF) "first_name": firstName,
    // if (isCPF) "last_name": lastName,
    // if (!isCPF) "first_name": respFirstName,
    // if (!isCPF) "last_name": respLastName,
  };

  print('[API] Payload completo:');
  print(json.encode(payload));

  try {
    print('[API] Enviando requisição para: http://localhost:8000/api/users/');

    final response = await http.post(
      Uri.parse('http://localhost:8000/api/users/'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(payload),
    ).timeout(const Duration(seconds: 10));

    print('[API] Resposta recebida - Status: ${response.statusCode}');
    print('[API] Corpo da resposta: ${response.body}');

    if (response.statusCode == 201) {
      print('[API] Cadastro realizado com sucesso!');
      return json.decode(response.body);
    } else {
      print('[API] Erro na resposta da API');
      throw Exception("Erro ${response.statusCode}: ${response.body}");
    }
  } catch (e) {
    print('[API] EXCEÇÃO durante a requisição: $e');
    rethrow;
  }
}

Future<void> storeTokens(String accessToken, String refreshToken) async {
  final storage = FlutterSecureStorage();
  print('[TOKEN] Armazenando tokens de acesso...');
  print('[TOKEN] Access Token: ${accessToken.substring(0, 20)}...');
  print('[TOKEN] Refresh Token: ${refreshToken.substring(0, 20)}...');

  await storage.write(key: 'access_token', value: accessToken);
  await storage.write(key: 'refresh_token', value: refreshToken);

  print('[TOKEN] Tokens armazenados com sucesso!');
}

=======
>>>>>>> Stashed changes
class _SignupPageState extends State<SignupPage> {
  bool isCPF = true;
  bool isChecked = false;

<<<<<<< Updated upstream
  // Controladores
  final cpfCnpjController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyController = TextEditingController();
  final respFirstNameController = TextEditingController();
  final respLastNameController = TextEditingController();
  final birthDateController = TextEditingController();

  void _handleSignup() async {
    print('[UI] Botão de cadastro pressionado');

    if (!isChecked) {
      print('[UI] Usuário não aceitou os termos');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Aceite os termos e condições")),
      );
      return;
    }

    print('[UI] Iniciando processo de cadastro...');
    print('[UI] Dados do formulário:');
    print('[UI] CPF/CNPJ: ${cpfCnpjController.text}');
    print('[UI] Nome: ${firstNameController.text}');
    print('[UI] Sobrenome: ${lastNameController.text}');
    print('[UI] Email: ${emailController.text}');
    print('[UI] Tipo: ${isCPF ? "CPF" : "CNPJ"}');

    if (isCPF) {
      print('[UI] Data Nasc.: ${birthDateController.text}');
    } else {
      print('[UI] Empresa: ${companyController.text}');
      print('[UI] Resp. Nome: ${respFirstNameController.text}');
      print('[UI] Resp. Sobrenome: ${respLastNameController.text}');
    }

    try {
      print('[UI] Chamando função signupUser...');
      final response = await signupUser(
        vat: cpfCnpjController.text,
        email: emailController.text,
        password: passwordController.text,
        firstName: isCPF ? firstNameController.text : respFirstNameController.text,
        lastName: isCPF ? lastNameController.text : respLastNameController.text,
        isCPF: isCPF,
        birthDate: isCPF ? birthDateController.text : null,
        companyName: !isCPF ? companyController.text : null,
        // Removidos pois são redundantes
        // respFirstName: !isCPF ? respFirstNameController.text : null,
        // respLastName: !isCPF ? respLastNameController.text : null,
      );

      print('[UI] Cadastro API realizado com sucesso!');
      final tokens = response['tokens'];

      print('[UI] Tokens recebidos:');
      print('[UI] Access: ${tokens['access']?.substring(0, 20)}...');
      print('[UI] Refresh: ${tokens['refresh']?.substring(0, 20)}...');

      await storeTokens(tokens['access'], tokens['refresh']);

      print('[UI] Navegando para AccountCreatedPage...');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AccountCreatedPage(
            accessToken: tokens['access'],
            refreshToken: tokens['refresh'],
          ),
        ),
      );

    } catch (e) {
      print('[UI] ERRO durante o cadastro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: ${e.toString()}")),
      );
    }
  }
=======
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xDDE8F1E8);
    final darkGreen = const Color(0xFF2F4F2F);
    final yellow = const Color(0xFFFFD700);

<<<<<<< Updated upstream
=======
    

>>>>>>> Stashed changes
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
<<<<<<< Updated upstream
                Expanded(
                  child: Column(
=======

                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset('assets/perfil.png', height: 100),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
>>>>>>> Stashed changes
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
<<<<<<< Updated upstream
                          toggleButton('CPF', isCPF, () => setState(() => isCPF = true)),
                          const SizedBox(width: 8),
                          toggleButton('CNPJ', !isCPF, () => setState(() => isCPF = false)),
                        ],
                      ),
=======
                          toggleButton('CPF', isCPF, () {
                            setState(() => isCPF = true);
                          }),
                          const SizedBox(width: 8),
                          toggleButton('CNPJ', !isCPF, () {
                            setState(() => isCPF = false);
                          }),
                        ],
                      ),

>>>>>>> Stashed changes
                    ],
                  ),
                ),
              ],
<<<<<<< Updated upstream
            ),

            const SizedBox(height: 12),
            TextField(
              controller: cpfCnpjController,
              decoration: inputStyle("Digite seu ${isCPF ? 'CPF' : 'CNPJ'}"),
              inputFormatters: [
                if (isCPF) 
                  // Formato para CPF: XXX.XXX.XXX-XX
                  FilteringTextInputFormatter.digitsOnly,
                if (!isCPF)
                  // Formato para CNPJ: XX.XXX.XXX/XXXX-XX
                  FilteringTextInputFormatter.digitsOnly,
              ],
            ),

            const SizedBox(height: 12),

            if (isCPF) ...[
              Row(
                children: [
                  Expanded(
                    child: textFieldWithLabel(
                      "Nome:", 
                      controller: firstNameController
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: textFieldWithLabel(
                      "Sobrenome:", 
                      controller: lastNameController
                    ),
                  ),
                ],
              ),
            ] else ...[
              textFieldWithLabel(
                "Nome Fantasia:", 
                controller: companyController
              ),
            ],

            const SizedBox(height: 12),
            textFieldWithLabel(
              "Email:", 
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 12),
            textFieldWithLabel(
              "Senha:", 
              obscure: true, 
              controller: passwordController
            ),
=======
),



          const SizedBox(height: 12),

          TextField(
            decoration: inputStyle("Digite seu ${isCPF ? 'CPF' : 'CNPJ'}"),
          ),

          const SizedBox(height: 12),

          if (isCPF) ...[
            rowTwoFields("Nome:", "Sobrenome:"),
          ] else ...[
            textFieldWithLabel("Nome Fantasia:"),
          ],

            const SizedBox(height: 12),

            textFieldWithLabel("Email:"),

            const SizedBox(height: 12),

            textFieldWithLabel("Senha:", obscure: true),
>>>>>>> Stashed changes

            if (!isCPF) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nome do responsável:",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ),
<<<<<<< Updated upstream
              Row(
                children: [
                  Expanded(
                    child: textFieldWithLabel(
                      "Nome:", 
                      controller: respFirstNameController
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: textFieldWithLabel(
                      "Sobrenome:", 
                      controller: respLastNameController
                    ),
                  ),
                ],
              ),
=======
              rowTwoFields("Nome:", "Sobrenome:"),
>>>>>>> Stashed changes
            ],

            if (isCPF) ...[
              const SizedBox(height: 12),
<<<<<<< Updated upstream
              textFieldWithLabel(
                "Data de Nascimento:", 
                controller: birthDateController,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    birthDateController.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  }
                },
              ),
            ],

            const SizedBox(height: 12),
=======
              textFieldWithLabel("Gênero:"),
            ],

            const SizedBox(height: 12),

>>>>>>> Stashed changes
            Row(
              children: [
                Checkbox(
                  value: isChecked,
<<<<<<< Updated upstream
                  onChanged: (value) => setState(() => isChecked = value!),
                  activeColor: darkGreen,
=======
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  activeColor: const Color(0xFF2F4F2F), // verde escuro
>>>>>>> Stashed changes
                  checkColor: Colors.white,
                ),
                const Text("Concordo com os termos e condições"),
              ],
            ),

<<<<<<< Updated upstream
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSignup,
=======

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AccountCreatedPage()),
                  );
                },
>>>>>>> Stashed changes
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Criar Conta',
                  style: TextStyle(
                    color: yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
<<<<<<< Updated upstream
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
=======

            GestureDetector(
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
>>>>>>> Stashed changes
              child: Text(
                'Já tem uma conta? Faça login',
                style: TextStyle(
                  color: darkGreen,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget toggleButton(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFD700) : const Color(0xFF2F4F2F),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

<<<<<<< Updated upstream
  Widget textFieldWithLabel(String label, {
    bool obscure = false, 
    required TextEditingController controller,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
=======
  Widget textFieldWithLabel(String label, {bool obscure = false}) {
>>>>>>> Stashed changes
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 16)),
        const SizedBox(height: 4),
        TextField(
<<<<<<< Updated upstream
          controller: controller,
          obscureText: obscure,
          decoration: inputStyle(""),
          onTap: onTap,
          readOnly: onTap != null,
          keyboardType: keyboardType,
=======
          obscureText: obscure,
          decoration: inputStyle(""),
>>>>>>> Stashed changes
        ),
      ],
    );
  }

<<<<<<< Updated upstream
=======
  Widget rowTwoFields(String label1, String label2) {
    return Row(
      children: [
        Expanded(child: textFieldWithLabel(label1)),
        const SizedBox(width: 12),
        Expanded(child: textFieldWithLabel(label2)),
      ],
    );
  }

>>>>>>> Stashed changes
  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white60,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
<<<<<<< Updated upstream

  @override
  void dispose() {
    cpfCnpjController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    companyController.dispose();
    respFirstNameController.dispose();
    respLastNameController.dispose();
    birthDateController.dispose();
    super.dispose();
  }
}
=======
}
>>>>>>> Stashed changes
