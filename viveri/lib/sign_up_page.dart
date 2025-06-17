import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account_created_page.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isCPF = true;
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xDDE8F1E8);
    final darkGreen = const Color(0xFF2F4F2F);
    final yellow = const Color(0xFFFFD700);

    

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset('assets/perfil.png', height: 100),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          toggleButton('CPF', isCPF, () {
                            setState(() => isCPF = true);
                          }),
                          const SizedBox(width: 8),
                          toggleButton('CNPJ', !isCPF, () {
                            setState(() => isCPF = false);
                          }),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
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
              rowTwoFields("Nome:", "Sobrenome:"),
            ],

            if (isCPF) ...[
              const SizedBox(height: 12),
              textFieldWithLabel("Gênero:"),
            ],

            const SizedBox(height: 12),

            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  activeColor: const Color(0xFF2F4F2F), // verde escuro
                  checkColor: Colors.white,
                ),
                const Text("Concordo com os termos e condições"),
              ],
            ),


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

            GestureDetector(
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
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

  Widget textFieldWithLabel(String label, {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 16)),
        const SizedBox(height: 4),
        TextField(
          obscureText: obscure,
          decoration: inputStyle(""),
        ),
      ],
    );
  }

  Widget rowTwoFields(String label1, String label2) {
    return Row(
      children: [
        Expanded(child: textFieldWithLabel(label1)),
        const SizedBox(width: 12),
        Expanded(child: textFieldWithLabel(label2)),
      ],
    );
  }

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
}
