import 'package:flutter/material.dart';
import 'package:viveri/about_account_cpf_page.dart';
import 'package:viveri/change_password_page.dart';
import 'package:viveri/custom_back_button.dart';

class AboutAccountCnpjPage extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String accessToken;

  const AboutAccountCnpjPage({
    Key? key,
    required this.userData,
    required this.accessToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extrai dados do usuário (CNPJ)
    final companyName = userData['company_name'] ?? '';
    final respFirstName = userData['first_name'] ?? '';
    final respLastName = userData['last_name'] ?? '';
    final email = userData['email'] ?? '';
    final vat = userData['vat']?.toString() ?? '';
    final phone = userData['phone']?.toString() ?? '000000000';
    final userId = userData['id']?.toString() ?? '';

    // Formata o CNPJ (se tiver 14 dígitos)
    String formattedVat = '**.***.***/****-**';
    if (vat.length == 14) {
      formattedVat = '${vat.substring(0, 2)}.${vat.substring(2, 5)}.${vat.substring(5, 8)}/${vat.substring(8, 12)}-${vat.substring(12)}';
    }

    // Formata o telefone
    String formattedPhone = phone;
    if (phone.length == 10) {
      formattedPhone = '(${phone.substring(0, 2)}) ${phone.substring(2, 6)}-${phone.substring(6)}';
    } else if (phone.length == 11) {
      formattedPhone = '(${phone.substring(0, 2)}) ${phone.substring(2, 7)}-${phone.substring(7)}';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seção do tipo de documento
                  const Text('Tipo de documento:', style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('CNPJ:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(formattedVat),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      // Ação para enviar documento
                    },
                    child: const Text('Enviar documento', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  const Divider(),
                  // Informações da empresa
                  _buildInfoRow('Nome vinculado ao CNPJ:', '$respFirstName $respLastName'),
                  _buildInfoRow('Nome fantasia:', companyName),
                  _buildInfoRow('ID da conta:', userId),
                  _buildInfoRow('Telefone de Contato:', formattedPhone),
                  _buildInfoRow('Email:', email),
                  _buildInfoRow('Nome do responsável:', '$respFirstName $respLastName'),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ChangePasswordPage(
                      //       accessToken: accessToken,
                      //     ),
                      //   ),
                      // );
                    },
                    child: const Text('Alterar senha', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  // Opção para desativar conta
                  TextButton(
                    onPressed: () {
                      // Ação para desativar conta
                    },
                    child: const Text('Desativar conta', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  // Opção para excluir conta
                  TextButton(
                    onPressed: () {
                      // Ação para excluir conta
                    },
                    child: const Text('Excluir conta', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  const SizedBox(height: 50),
                  // Rodapé com informações de versão
                  const Center(
                    child: Text(
                      'Version 1.0',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            // Header fixo que fica sobre o conteúdo
            Container(
              height: 60,
              color: const Color(0xFF425C44),
              child: const Center(
                child: Text('Sobre a conta', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            // Botão de voltar posicionado sobre tudo
            Positioned(
              left: 16,
              top: 8,
              child: CustomBackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir uma linha de informação
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}