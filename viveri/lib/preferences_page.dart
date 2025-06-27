import 'package:flutter/material.dart';
import 'package:viveri/custom_switch.dart';
import 'package:viveri/custom_back_button.dart';

// Página de preferências do usuário
class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool _notifications = true;
  bool _darkMode = false;
  String _distanceUnit = 'Km';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1), // Cor de fundo da tela
      body: SafeArea(
        child: Stack(
          children: [
            // O conteúdo fica aqui, no fundo do Stack.
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0), // Padding para o conteúdo não ficar atrás do header
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Opção de notificações
                  _buildSwitchOption('Notificações', _notifications, (value) {
                    setState(() {
                      _notifications = value;
                    });
                  }),
                  const SizedBox(height: 20),
                  // Opção de tema do app
                  _buildSwitchOption('Tema do app', _darkMode, (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  }),
                  const SizedBox(height: 20),
                  // Opção de unidade de distância
                  _buildDistanceUnitOption(),
                  const SizedBox(height: 20),
                  // Opção para editar interesses
                  const Text(
                    'Editar interesses',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40), // Espaçamento fixo em vez de Spacer
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
              height: 60, // Altura do header
              color: const Color(0xFF425C44),
              child: const Center(
                child: Text('Preferências', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            // Botão de voltar posicionado sobre tudo
            Positioned(
              left: 16, // Mais para a esquerda
              top: 8,  // Posição mais alta
              child: CustomBackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir uma opção com switch customizado
  Widget _buildSwitchOption(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        CustomSwitch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Widget para construir a opção de unidade de distância
  Widget _buildDistanceUnitOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Unidade de distância',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _distanceUnit = _distanceUnit == 'Km' ? 'Mi' : 'Km';
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF425C44),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _distanceUnit,
              style: TextStyle(
                color: Color(0xFFF4B134),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
} 